from BLEGeoloclib import BLEGeoloclib

#Handler = SimpleHTTPServer.SimpleHTTPRequestHandler


hostName = "localhost"
Port = 8080

blegeoloc_calc = BLEGeoloclib.BLEGeoloc_calculation()

print("LOG TEST: BLE Rssi", blegeoloc_calc.RSSItoD(10))
print("LOG TEST: BLE trilateration", blegeoloc_calc.trilateration(10,30,87))


"""
if __name__ == "__main__":        
    webServer = HTTPServer((hostName, Port), MyServer)
    print("Server started http://%s:%s" % (hostName, Port))

    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("Server stopped.")

"""