# Generated by Django 5.0.2 on 2024-02-08 07:30

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='District',
            fields=[
                ('dr_id', models.AutoField(primary_key=True, serialize=False)),
                ('dr_name', models.CharField(max_length=100)),
                ('dr_name_en', models.CharField(max_length=100)),
                ('pr_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='users.province')),
            ],
        ),
    ]