from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import Province, District, Village
from .serializers import *

@api_view(['GET'])
def get_province_data(request):
    pr_id = request.GET.get('pr_id')
    if pr_id is not None:
        provinces = Province.objects.filter(pr_id=pr_id)
    else:
        provinces = Province.objects.all()
    
    serializer = ProvinceSerializer(provinces, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def get_district_data(request):
    pr_id = request.GET.get('pr_id')
    if pr_id is not None:
        districts = District.objects.filter(pr_id=pr_id)
    else:
        districts = District.objects.all()
    
    serializer = DistrictSerializer(districts, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def get_village_data(request):
    dr_id = request.GET.get('dr_id')
    if dr_id is not None:
        villages = Village.objects.filter(dr_id=dr_id)
    else:
        villages = Village.objects.all()
    
    serializer = VillageSerializer(villages, many=True)
    return Response(serializer.data)
