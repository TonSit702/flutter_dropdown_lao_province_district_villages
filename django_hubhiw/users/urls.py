from django.urls import path
from . import views

urlpatterns = [
    path('get_province_data/', views.get_province_data, name='get_province_data'),
    path('get_district_data/', views.get_district_data, name='get_district_data'),
    path('get_village_data/', views.get_village_data, name='get_village_data'),
    # Add other URL patterns as needed
]
