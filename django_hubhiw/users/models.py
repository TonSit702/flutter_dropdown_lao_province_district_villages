from django.db import models
from django.contrib.auth.models import User

class Province(models.Model):
    pr_id = models.AutoField(primary_key=True)
    pr_name = models.CharField(max_length=200)
    pr_name_en = models.CharField(max_length=200)

    def __str__(self):
        return self.pr_name

class District(models.Model):
    dr_id = models.AutoField(primary_key=True)
    dr_name = models.CharField(max_length=100)
    dr_name_en = models.CharField(max_length=100)
    pr_id = models.ForeignKey('Province', on_delete=models.CASCADE)

    def __str__(self):
        return self.dr_name

class Village(models.Model):
    vill_id = models.AutoField(primary_key=True)
    vill_name = models.CharField(max_length=100)
    vill_name_en = models.CharField(max_length=100)
    dr_id = models.ForeignKey('District', on_delete=models.CASCADE)

    def __str__(self):
        return self.vill_name