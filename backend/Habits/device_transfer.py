import base64
import hashlib

from cryptography.fernet import Fernet, InvalidToken
from django.conf import settings


class DeviceTransferCipherError(Exception):
    pass


def _cipher():
    secret = settings.DEVICE_TRANSFER_ENCRYPTION_KEY or settings.SECRET_KEY
    key = base64.urlsafe_b64encode(hashlib.sha256(secret.encode('utf-8')).digest())
    return Fernet(key)


def encrypt_snapshot(payload):
    return _cipher().encrypt(payload)


def decrypt_snapshot(payload):
    try:
        return _cipher().decrypt(bytes(payload))
    except InvalidToken as exc:
        raise DeviceTransferCipherError('The saved backup could not be decrypted.') from exc
