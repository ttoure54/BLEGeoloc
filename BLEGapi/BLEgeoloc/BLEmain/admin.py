from django.contrib import admin
from .models import Beacons

# Register your models here.


"""
class ItemsAdmin(admin.ModelAdmin):

    list_display = [
        'Beacons'
    ]
"""
admin.site.register(Beacons)
#admin.site.register(User)