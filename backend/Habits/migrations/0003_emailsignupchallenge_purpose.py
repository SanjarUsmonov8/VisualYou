from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [('Habits', '0002_emailsignupchallenge')]

    operations = [
        migrations.AddField(
            model_name='emailsignupchallenge',
            name='purpose',
            field=models.CharField(
                choices=[
                    ('signup', 'Sign up'),
                    ('password_reset', 'Password reset'),
                ],
                db_index=True,
                default='signup',
                max_length=24,
            ),
        ),
    ]
