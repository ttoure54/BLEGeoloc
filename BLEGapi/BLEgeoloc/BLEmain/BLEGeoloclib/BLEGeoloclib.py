from http.server import HTTPServer, BaseHTTPRequestHandler
import math

"""

class BLEGeoloc_server(BaseHTTPRequestHandler):

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(bytes("<html><head><title>https://pythonbasics.org</title></head>", "utf-8"))
        self.wfile.write(bytes("<p>Request: %s</p>" % self.path, "utf-8"))
        self.wfile.write(bytes("<body>", "utf-8"))
        self.wfile.write(bytes("<p>This is an example web server.</p>", "utf-8"))
        self.wfile.write(bytes("</body></html>", "utf-8"))
    
    def parsing_request(self):
        pass

"""


class BLEGeoloc_calculation():


    def __init__(self):

        self.Becons1 = {"LAT":48.98441447913894, "LONG":1.7035273579066978}
        self.Becons2 = {"LAT":48.984383898526396, "LONG":1.7035698229991323}
        self.Becons3 = {"LAT":48.98441292521372, "LONG":1.703529669313517}

        self.Becons1_sq = {"LAT":48.98441447913894**2, "LONG":1.7035273579066978**2}
        self.Becons2_sq = {"LAT":48.984383898526396**2, "LONG":1.7035698229991323**2}
        self.Becons3_sq = {"LAT":48.98441292521372**2, "LONG":1.703529669313517**2}

        self.P_d0 = 20 #Power in dbm at 1 leter distance
        self.n = 5 #signal propagation constant 
    
        self.side_b1b2 = 45
        self.side_b2b3 = 55
        self.side_b3b1 = 65
    

    def trilateration(self,RSSI1, RSSI2, RSSI3):
        

        d1_sq =self.RSSItoD(RSSI1)**2
        d2_sq=self.RSSItoD(RSSI2)**2
        d3_sq =self.RSSItoD(RSSI3)**2


        X_num_P1 = (self.Becons1_sq["LAT"]+self.Becons1_sq["LONG"]-d1_sq)*(self.Becons3["LONG"]-self.Becons2["LONG"])
        X_num_P2 = (self.Becons2_sq["LAT"]+self.Becons2_sq["LONG"]-d2_sq)*(self.Becons1["LONG"]-self.Becons3["LONG"])
        X_num_P3 = (self.Becons3_sq["LAT"]+self.Becons3_sq["LONG"]-d3_sq)*(self.Becons2["LONG"]-self.Becons1["LONG"])

        X_num = X_num_P1 + X_num_P2 + X_num_P3
       
        X_denum_P1 = self.Becons1["LAT"]*(self.Becons3["LONG"]-self.Becons2["LONG"])
        X_denum_P2 = self.Becons2["LAT"]*(self.Becons1["LONG"]-self.Becons3["LONG"])
        X_denum_P3 = self.Becons3["LAT"]*(self.Becons2["LONG"]-self.Becons1["LONG"])

        X_denum = 2*(X_denum_P1+X_denum_P2+X_denum_P3)
        X= X_num/X_denum


        Y_num_P1 = (self.Becons1_sq["LAT"]+self.Becons1_sq["LONG"]-d1_sq)*(self.Becons3["LAT"]-self.Becons2["LAT"])
        Y_num_P2 = (self.Becons2_sq["LAT"]+self.Becons2_sq["LONG"]-d2_sq)*(self.Becons1["LAT"]-self.Becons3["LAT"])
        Y_num_P3 = (self.Becons3_sq["LAT"]+self.Becons3_sq["LONG"]-d3_sq)*(self.Becons2["LAT"]-self.Becons1["LAT"])

        Y_num = Y_num_P1 + Y_num_P2 + Y_num_P3
       
        Y_denum_P1 = self.Becons1["LONG"]*(self.Becons3["LAT"]-self.Becons2["LAT"])
        Y_denum_P2 = self.Becons2["LONG"]*(self.Becons1["LAT"]-self.Becons3["LAT"])
        Y_denum_P3 = self.Becons3["LONG"]*(self.Becons2["LAT"]-self.Becons1["LAT"])

        print ("LOG LIB", Y_denum_P1)
        print ("LOG LIB", Y_denum_P2)
        print ("LOG LIB", Y_denum_P3)

        Y_denum = 2*(Y_denum_P1+Y_denum_P2+Y_denum_P3)

        print ("LOG LIB", Y_denum)
        Y= Y_num/Y_denum

        return {"LONGITUDE":X, "LATITUDE":Y}
    

    def RSSItoD(self,RSSI):

        d= 10**((self.P_d0-RSSI)/10*self.n)

        return d
        

"""


"""