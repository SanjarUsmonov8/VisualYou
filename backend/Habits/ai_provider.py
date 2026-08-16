import json
import logging
import re
from urllib import error, parse, request

from django.conf import settings


logger = logging.getLogger(__name__)


SYSTEM_INSTRUCTION = '''
You are Visual You's supportive habit coach. Help users reflect on habits,
build realistic routines, and follow their own gradual-reduction plans.
Use the same language as the user unless they ask for another language.
Keep answers practical, compassionate, and reasonably concise.

Important safety rules:
- Never diagnose, assess, or claim the medical condition of an organ, muscle,
  mind, or body part. Visual You body colors are symbolic progress only.
- Do not present symbolic scores as medical evidence.
- Do not tell minors to use alcohol, nicotine, explicit content, or another
  age-restricted or harmful product as part of a reduction plan.
- Do not shame users for unwanted habits or missed tracking.
- For urgent symptoms, self-harm, poisoning, severe withdrawal, or immediate
  danger, advise contacting local emergency services or a qualified clinician.
- Clearly distinguish general education from professional medical advice.
'''.strip()


class AIProviderError(Exception):
    pass


def generate_reply(messages, *, image_base64='', image_mime_type=''):
    api_key = settings.GEMINI_API_KEY
    if not api_key:
        raise AIProviderError('The AI service is not configured yet.')

    model = settings.GEMINI_MODEL
    if not re.fullmatch(r'[A-Za-z0-9._-]+', model):
        raise AIProviderError('The configured AI model name is invalid.')

    contents = []
    recent_messages = list(messages)[-settings.GEMINI_HISTORY_MESSAGE_LIMIT :]
    for index, message in enumerate(recent_messages):
        role = 'model' if message.role == 'assistant' else 'user'
        parts = [{'text': message.content}]
        if index == len(recent_messages) - 1 and image_base64:
            parts.insert(
                0,
                {
                    'inline_data': {
                        'mime_type': image_mime_type,
                        'data': image_base64,
                    }
                },
            )
        contents.append({'role': role, 'parts': parts})

    payload = {
        'system_instruction': {'parts': [{'text': SYSTEM_INSTRUCTION}]},
        'contents': contents,
        'generationConfig': {
            'maxOutputTokens': settings.GEMINI_MAX_OUTPUT_TOKENS,
        },
    }
    endpoint = (
        'https://generativelanguage.googleapis.com/v1beta/models/'
        f'{parse.quote(model, safe="")}:generateContent'
    )
    api_request = request.Request(
        endpoint,
        data=json.dumps(payload).encode('utf-8'),
        headers={
            'Content-Type': 'application/json',
            'x-goog-api-key': api_key,
        },
        method='POST',
    )
    try:
        with request.urlopen(api_request, timeout=settings.GEMINI_TIMEOUT_SECONDS) as response:
            result = json.loads(response.read().decode('utf-8'))
    except error.HTTPError as exc:
        detail = _provider_error_detail(exc)
        raise AIProviderError(detail) from exc
    except (error.URLError, TimeoutError, json.JSONDecodeError) as exc:
        raise AIProviderError('The AI service is temporarily unavailable.') from exc

    try:
        parts = result['candidates'][0]['content']['parts']
        text = ''.join(part.get('text', '') for part in parts).strip()
    except (KeyError, IndexError, TypeError):
        text = ''
    if not text:
        raise AIProviderError('The AI service returned an empty response.')
    return text


def _provider_error_detail(exc):
    provider_message = ''
    try:
        payload = json.loads(exc.read().decode('utf-8'))
        provider_message = str(payload.get('error', {}).get('message', '')).strip()
    except (AttributeError, UnicodeDecodeError, json.JSONDecodeError):
        pass
    logger.warning(
        'Gemini API returned HTTP %s: %s',
        exc.code,
        provider_message[:500] or exc.reason,
    )
    if exc.code in (401, 403):
        return 'The AI service credentials were rejected.'
    if exc.code == 429:
        return 'The AI usage limit has been reached. Please try again later.'
    if exc.code == 404:
        return 'The configured AI model is unavailable.'
    if 500 <= exc.code < 600:
        return 'The AI service is temporarily unavailable.'
    return 'The AI service could not process that request.'
