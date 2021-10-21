from django.shortcuts import render
from django.http import JsonResponse
from .BLEGeoloclib import BLEGeoloclib
from django.views.decorators.csrf import csrf_exempt

# Create your views here.

from .models import *

import datetime 
import json

# Create your views here.

blegeoloc_calc = BLEGeoloclib.BLEGeoloc_calculation()



def home(request):

    beacons = Beacons.objects.get()

    print("LOG Request body:",request.body)
    print("LOG Database title, position: ", beacons.title, beacons.Latitude)
    return render(request,'BLEgeoloc/home.html', {}) 


@csrf_exempt
def BLEGeoloc(request):
    
    data = json.loads(request.body)
    print(request.body)
    
    B1_rssi=int(data["B1"])
    B2_rssi=int(data["B2"])
    B3_rssi=int(data["B3"])

    print("LOG B1_rssi:", B1_rssi)
    print("LOG B2_rssi:", B2_rssi)
    print("LOG B3_rssi:", B3_rssi)

    Coord = blegeoloc_calc.trilateration(B1_rssi,B2_rssi,B3_rssi)

    print("LOG TEST: BLE trilateration", Coord)
    

    return JsonResponse( Coord, safe = False)