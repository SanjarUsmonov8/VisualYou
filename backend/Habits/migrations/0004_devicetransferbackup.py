import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ('Habits', '0003_emailsignupchallenge_purpose'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='DeviceTransferBackup',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('encrypted_payload', models.BinaryField()),
                ('schema_version', models.PositiveIntegerField()),
                ('source_device', models.CharField(blank=True, max_length=120)),
                ('payload_size', models.PositiveIntegerField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('expires_at', models.DateTimeField(db_index=True)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='device_transfer_backup', to=settings.AUTH_USER_MODEL)),
            ],
            options={'ordering': ('-updated_at',)},
        ),
    ]
