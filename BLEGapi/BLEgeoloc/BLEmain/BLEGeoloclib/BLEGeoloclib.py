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

        self.Becons1 = {"X":0, "Y":0}
        self.Becons2 = {"X":0.85, "Y":1.1}
        self.Becons3 = {"X":1.2, "Y":0.75}

        self.Becons1_sq = {"X":0, "Y":0}
        self.Becons2_sq = {"X":(0.85)**2, "Y":(1.1)**2}
        self.Becons3_sq = {"X":(1.2)**2, "Y":(0.75)**2}

        self.P_d0 = -37 #Power in dbm at 1 leter distance
        self.n = 1 #signal propagation constant 
    
        self.side_b1b2 = 1.39
        self.side_b2b3 = 0.49
        self.side_b3b1 = 1.42
    

    def trilateration(self,RSSI1, RSSI2, RSSI3):
        

        d1_sq =self.RSSItoD(RSSI1)**2
        d2_sq=self.RSSItoD(RSSI2)**2
        d3_sq =self.RSSItoD(RSSI3)**2


        X_num_P1 = (self.Becons1_sq["X"]+self.Becons1_sq["Y"]-d1_sq)*(self.Becons3["Y"]-self.Becons2["Y"])
        X_num_P2 = (self.Becons2_sq["X"]+self.Becons2_sq["Y"]-d2_sq)*(self.Becons1["Y"]-self.Becons3["Y"])
        X_num_P3 = (self.Becons3_sq["X"]+self.Becons3_sq["Y"]-d3_sq)*(self.Becons2["Y"]-self.Becons1["Y"])

        X_num = X_num_P1 + X_num_P2 + X_num_P3
       
        X_denum_P1 = self.Becons1["X"]*(self.Becons3["Y"]-self.Becons2["Y"])
        X_denum_P2 = self.Becons2["X"]*(self.Becons1["Y"]-self.Becons3["Y"])
        X_denum_P3 = self.Becons3["X"]*(self.Becons2["Y"]-self.Becons1["Y"])

        X_denum = 2*(X_denum_P1+X_denum_P2+X_denum_P3)
        X= X_num/X_denum


        Y_num_P1 = (self.Becons1_sq["X"]+self.Becons1_sq["Y"]-d1_sq)*(self.Becons3["X"]-self.Becons2["X"])
        Y_num_P2 = (self.Becons2_sq["X"]+self.Becons2_sq["Y"]-d2_sq)*(self.Becons1["X"]-self.Becons3["X"])
        Y_num_P3 = (self.Becons3_sq["X"]+self.Becons3_sq["Y"]-d3_sq)*(self.Becons2["X"]-self.Becons1["X"])

        Y_num = Y_num_P1 + Y_num_P2 + Y_num_P3
       
        Y_denum_P1 = self.Becons1["Y"]*(self.Becons3["X"]-self.Becons2["X"])
        Y_denum_P2 = self.Becons2["Y"]*(self.Becons1["X"]-self.Becons3["X"])
        Y_denum_P3 = self.Becons3["Y"]*(self.Becons2["X"]-self.Becons1["X"])

        print ("LOG LIB", Y_denum_P1)
        print ("LOG LIB", Y_denum_P2)
        print ("LOG LIB", Y_denum_P3)

        Y_denum = 2*(Y_denum_P1+Y_denum_P2+Y_denum_P3)

        print ("LOG LIB", Y_denum)
        Y= Y_num/Y_denum

        return {"X":X, "Y":Y}
    

    def RSSItoD(self,RSSI):

        d= 10**((self.P_d0-RSSI)/10*self.n)

        return d
        

"""


"""
