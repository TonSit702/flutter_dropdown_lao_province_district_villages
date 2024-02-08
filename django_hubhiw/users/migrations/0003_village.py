# Generated by Django 5.0.2 on 2024-02-08 08:14

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0002_district'),
    ]

    operations = [
        migrations.CreateModel(
            name='Village',
            fields=[
                ('vill_id', models.AutoField(primary_key=True, serialize=False)),
                ('vill_name', models.CharField(max_length=100)),
                ('vill_name_en', models.CharField(max_length=100)),
                ('dr_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='users.district')),
            ],
        ),
    ]
