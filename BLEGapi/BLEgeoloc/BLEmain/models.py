from django.db import models
from django.contrib.auth.models import User



#admin passwd

class Beacons(models.Model):

    title = models.CharField(max_length=15)
    Latitude = models.DecimalField(max_digits=20, decimal_places=16)
    Longitude = models.DecimalField(max_digits=20, decimal_places=16)
    #High = models.DecimalField(max_digits=20, decimal_places=16)


   



#Classes for tests purposes 
