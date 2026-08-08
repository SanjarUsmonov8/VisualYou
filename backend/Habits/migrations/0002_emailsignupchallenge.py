import uuid

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [('Habits', '0001_initial')]

    operations = [
        migrations.CreateModel(
            name='EmailSignupChallenge',
            fields=[
                (
                    'id',
                    models.UUIDField(
                        default=uuid.uuid4,
                        editable=False,
                        primary_key=True,
                        serialize=False,
                    ),
                ),
                ('email', models.EmailField(db_index=True, max_length=254)),
                ('code_hash', models.CharField(max_length=128)),
                ('setup_token_hash', models.CharField(blank=True, max_length=128)),
                ('expires_at', models.DateTimeField(db_index=True)),
                ('verified_at', models.DateTimeField(blank=True, null=True)),
                ('consumed_at', models.DateTimeField(blank=True, null=True)),
                ('failed_attempts', models.PositiveSmallIntegerField(default=0)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
            ],
        ),
    ]
