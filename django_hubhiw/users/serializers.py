# serializers.py
from rest_framework import serializers
from .models import Province, District, Village

class DistrictSerializer(serializers.ModelSerializer):
    class Meta:
        model = District
        fields = ['dr_id', 'dr_name', 'dr_name_en', 'pr_id']

class ProvinceSerializer(serializers.ModelSerializer):
    districts = DistrictSerializer(many=True, read_only=True)  # Add this line

    class Meta:
        model = Province
        fields = ['pr_id', 'pr_name', 'pr_name_en', 'districts']

class VillageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Village
        fields = ['vill_id', 'vill_name', 'vill_name_en', 'dr_id']