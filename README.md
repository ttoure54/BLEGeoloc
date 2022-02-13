# BLEGeoloc

This project aims to define and display the indoor position of user on his/her phone application thanks to bluetooth beacons with fixed positions.
We also developed an administration interface to configure the fixed BLE module positions and manage access.

iOS application 

![Alt text](readme_img/mainview.png?raw=true "Main View")
![Alt text](readme_img/positionview.png?raw=true "Position View")

## Description

The application retrieves the RSSI (dBm) values ​​of the 3 bluetooth beacons, it sends these values ​​to the API, the API calculates the user's x and y position.
Then the API sends the x and y values ​​to the application, the application displays the user's x and y position.

1beacon= 1 arduino unit + 1 HC-05 unit

## Getting Started
This repository provides,the beacons arduino codes, the public server API codes, 2 applications (Android, iOS),

### Dependencies

* Describe any prerequisites, libraries, OS version, etc., needed before installing program.
* Développement Environnement: Linux, MacOS, ARDUINO IDE (last version)
* Python3 
* Libraries : Django, virtualenv
* MIT App Inventor
* Optional : Xcode, SwiftUI

### Installing
For a better library management, we used the virtual environment virtualenv. It is important to install it, then create one and launch before installing any python library.   

Installing: virtualenv: python3 -m pip install virtualenv
Create a venv: virtualenv venv_name -p python3 

####Linux
* How/where to download your program
* [ADUINO IDE](https://www.arduino.cc/en/software)
* Python3: `sudo apt-get update`,` sudo apt-get install python3.6`
* Django :`sudo apt-get update`,`sudo apt-get install Django`
* [MIT App Inventor]( http://appinventor.mit.edu/)

####MacOS
* How/where to download your program
* [ADUINO IDE](https://www.arduino.cc/en/software)
* Python3:  "brew install python3.6`
* Django : python3 -m pip install Django
* [MIT App Inventor]( http://appinventor.mit.edu/)



### Executing program

####API running 

*Modifying "/BLEGapi/BLEGeoloc/BLEgeoloc/settings.py" with your host server IP in "ALLOWED_HOSTS = []"
*source venv_name/bin/activate
*python manage.py createsuperuser
*python manage.py makemigrations 
*python manage.py migrate 
*sudo ifw 8000 
*python manage.py runserver 0.0.0.0:8000 

*Test : Connect to http://IP:8000/ on a browser 
*Using: Request on http://IP:8000/BLEgeoloc with JSON file as shown in BLEGapi/BLEGtestclient
*Administration : Connect to http://IP:8000/admin on a browser, enter superuser login and password




## Help

Any advise for common problems or issues.`Read the documentation Acknowledgments`

## Authors & University

University

* UVSQ - Institut des Sciences et Techniques des Yvelines (ISTY) - Mantes-la-ville 
* CFAI Mécavenir

Supervisor name

* Monsieur Hakim Latrache

Contributors names

* Talla TOURE : tallatoure.pro@gmail.com
* PAKA Howard
* Sokhna Aissatou DRAME 



## Acknowledgments

Inspiration, code snippets, etc.
* [Mise en marche du module Bluetooth HC-05](https://www.gotronic.fr/pj2-guide-de-mise-en-marche-du-module-bluetooth-hc-1546.pdf)
* [Communication Bluetooth avec le module HC-05](https://openclassrooms.com/fr/courses/5224916-developpez-un-robot-mobile-connecte-par-bluetooth/5509461-installez-la-communication-bluetooth-avec-le-module-hc05)
* [Installer la communication Bluetooth avec le module HC-05](https://openclassrooms.com/fr/courses/5224916-developpez-un-robot-mobile-connecte-par-bluetooth/5509461-installez-la-communication-bluetooth-avec-le-module-hc05)
* [Commande At HC-05](https://s3-sa-east-1.amazonaws.com/robocore-lojavirtual/709/HC-05_ATCommandSet.pdf)
* [Sending receiving with HC-05 mit app inventor](https://roboindia.com/tutorials/sending-receiving-with-hc05-mit-app-inventor/)
* [MDPI](https://www.mdpi.com/2076-3417/11/11/4902/htm)
* [Wireless bluetooth](https://www.silabs.com/wireless/bluetooth/bluetooth-5-1)
* [ESP32 BLE Android App Arduino IDE](https://www.instructables.com/ESP32-BLE-Android-App-Arduino-IDE-AWESOME/)
* [AccuRTLS](https://www.blueupbeacons.com/index.php?page=locate_accuRTLS)
