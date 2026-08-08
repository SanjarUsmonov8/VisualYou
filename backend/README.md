# Visual You backend

This directory contains the Django and Django REST Framework backend. Backend
state is stored in PostgreSQL. JSON is used only for API request and response
payloads; JSON files are not used as storage.

## Local setup

1. Create a PostgreSQL database and user:

   ```sql
   CREATE USER visualyou WITH PASSWORD 'your-password';
   CREATE DATABASE visualyou OWNER visualyou;
   ```

2. From the repository root, enter the backend and activate its virtual
   environment:

   ```powershell
   cd backend
   .\venv\Scripts\Activate.ps1
   ```

3. Install backend dependencies:

   ```powershell
   python -m pip install -r requirements.txt
   ```

4. Copy `.env.example` to `.env` and replace the development placeholders with
   your local PostgreSQL credentials and a private Django secret key. The `.env`
   file stays inside this directory and is ignored by Git.

5. Apply migrations only after the PostgreSQL values are correct:

   ```powershell
   python manage.py migrate
   python manage.py createsuperuser
   python manage.py runserver
   ```

The project uses `Habits.User` as its custom user model. This is configured
before the initial application migration so the user table can evolve without
replacing Django's default user model later.

## API

All API endpoints use JSON and are versioned under `/api/v1/`:

- `GET /api/v1/health/` — unauthenticated health check
- `POST /api/v1/auth/email/start/` — email a six-digit verification code
- `POST /api/v1/auth/email/verify/` — verify the code and receive a short-lived password setup token
- `POST /api/v1/auth/email/complete/` — create the password and receive an API token
- `POST /api/v1/auth/email/login/` — log in with email and password
- `POST /api/v1/auth/logout/` — invalidate the current token
- `GET|PATCH /api/v1/me/` — read or update the signed-in user
- `POST /api/v1/sync/` — push pending local changes and pull server changes
- `/api/v1/ai/conversations/` — authenticated AI conversation history
- `/api/v1/ai/conversations/{id}/messages/` — list or store user messages

Authenticated requests use this header:

```text
Authorization: Token <token returned by register or login>
```

Use HTTPS outside local development because API tokens must not travel over an
unencrypted connection.

## Verification email delivery

Local development uses Django's console email backend, so verification messages
and codes appear in the terminal running `python manage.py runserver`. To send
real messages, set `DJANGO_EMAIL_BACKEND` to
`django.core.mail.backends.smtp.EmailBackend` and fill the `EMAIL_*` values in
`backend/.env`. Use the SMTP credentials supplied by your email provider; do not
commit them to the repository.

## Offline sync contract

The phone remains the immediate source of truth while offline. Each sync call
is retry-safe: local record IDs identify records, `updated_at` resolves
conflicts, and `deleted_at` carries deletions without accidentally restoring
them on another device. The server returns an integer cursor for the next pull.

Example request:

```json
{
  "device_id": "8dbb5a78-94fb-4ccd-9ea9-ef25809bcd2f",
  "cursor": 0,
  "habit_definitions": [
    {
      "id": "water",
      "name_key": "Drinking water",
      "category": "good",
      "is_active": true,
      "is_favorite": true,
      "created_at": "2026-08-03T10:00:00Z",
      "updated_at": "2026-08-03T10:00:00Z",
      "deleted_at": null
    }
  ],
  "habit_log_entries": [],
  "body_part_states": [],
  "graph_history_entries": [],
  "custom_graph_rules": [],
  "special_habit_graphs": [],
  "reduction_plans": []
}
```

The response contains `cursor`, `has_more`, and a `changes` object with the
same seven collections. If `has_more` is true, call sync again with the returned
cursor until it becomes false. After a successful response, the Flutter client
can mark uploaded rows as synced and store returned `remote_id` values.

AI conversations and messages are stored relationally in PostgreSQL. Calling an
external AI model is intentionally not enabled yet; that requires a provider,
secret API key, cost limits, and the app's non-diagnostic safety policy.
