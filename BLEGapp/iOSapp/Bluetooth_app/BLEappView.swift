//
//  ProfileView.swift
//  Bluetooth_app
//
//  Created by Talla Toure on 28/10/2021.
//  Last update : 15/11/2021
//  Performing display views 

import SwiftUI



//Initial body request : test usage
let JSONbeacons : String = """

{
    "ID":"-12344567",
    "B1":"-102",
    "B2":"-85",
    "B3":"-24"
}

"""

//Main View handling the other prcess and instanciate all previous class
struct BLEappView: View {
    
    @State var isPresented = false
    var httpconnection = HTTPconnection()
    @ObservedObject var Blemanager = BLEManager()
    var beacons = Beacons()
    @State var JSONbody: String = JSONbeacons

    
    //let JSOndata = JSONbeacons.data(using: .utf8)


    var body: some View {
        VStack {
            VStack {
                Header()
                ProfileText()
                StatusView(BLEmanager: Blemanager)
            }
            Spacer()
            if Blemanager.switchedOn{
                Text("Bluetooth turned on")
                    .foregroundColor(.green)
            }else{
                Text("Bluetooth turned off")
                    .foregroundColor(.red)
            }
            Spacer()
            
            HStack {
                HStack (spacing: 10) {
                    Button(action: {
                        self.Blemanager.startScanning()
                        //print("Start Scanning")
                    }) {
                        Text("Start Scanning")
                    }
                    Spacer()
                    Button(action: {
                        self.Blemanager.stopScanning()
                        //print("Stop Scanning")
                    }) {
                        Text("Stop Scanning")
                    }
                }.padding()
            }
            Spacer()
            
            Button (
                action: {
                    httpconnection.sendData(httpbody: JSONbody)
                    self.isPresented = true },
                label: {
                    Text("Show Position").padding()
            })
            .sheet(isPresented: $isPresented, content: {
                //Settings_profileView()
                PowerOnView(httpconnection: httpconnection, Blemanager: Blemanager, isPresented: $isPresented, JSONbody: JSONbody, beacons: beacons)
            })
        }
    }
}


struct PowerOnView: View{
    
    @State var httpconnection: HTTPconnection
    @State var Blemanager :  BLEManager
    @State var xnewpos :  Float = 0.0
    @State var ynewpos :  Float = 0.0
    @Binding var isPresented : Bool
    @State var stepperValue : Int = 0
    @State var JSONbody: String
    @State var beacons: Beacons
    //@Binding var newPosition : String
    
    
    var body: some View{
        
        VStack{
            
            Text("Your Position")
                .padding(85)
                .font(.largeTitle)
            Spacer()
            HStack{
                Text(String(format: "X position : %.2f ",xnewpos) ).padding(10)
                Text(String(format: "Y position : %.2f ",ynewpos) ).padding(10)
            }.padding()
            updatepositionView(X: xnewpos, Y: ynewpos)
            Spacer()
            Button(action: {
                JSONbody = try! beacons.createJSON(ID: 12345, B1:Blemanager.peripheralsBest[0].RSSI,
                    B2:Blemanager.peripheralsBest[1].RSSI,
                    B3:Blemanager.peripheralsBest[2].RSSI)
                print ("LOG : hhtpbody")
                httpconnection.sendData(httpbody: JSONbody);
                xnewpos = httpconnection.Xposition;
                ynewpos = httpconnection.Yposition;
    
            }){Text("Update your position")}
            Spacer()
            Button(action: {isPresented=false}) {
                Text("Close")
            }.padding()
            
        }
    }
}


//Struct allowing to encode the body request in JSON
struct Beacons : Codable{
    
   // var ID : Int
   //var Beacon1 : Int
   //var Beacon2 : Int
   //var Beacon3 : Int
   //var Blemanager = BLEManager()
    
    func createJSON(ID: Int, B1:Int, B2:Int, B3: Int) -> String {
        
        let retJOSN = """

        {
            "ID":"\(ID)",
            "B1":"\(B1)",
            "B2":"\(B2)",
            "B3":"\(B3)"
        }
        """
        return retJOSN
    }
    
}

//Struct allowing to decode the body request in JSON
struct NewPositions : Codable{
    
    var X : Float
    var Y : Float
}

//Main class for managing HTTP connection and sending the request

class HTTPconnection : ObservableObject{
        
    var newpositions = NewPositions.self
    @Published var Xposition : Float = 0.0
    @Published var Yposition : Float = 0.0
    //var position = Position.self
    //var Xposition : Float = 0.0
    //var Yposition : Float = 0.0

    
    func sendData(httpbody: String){
        
        //@State var httpbody : String = "test co"
    
        
        let url = URL(string: "http://34.140.109.203:8000/BLEGeoloc/")!
        //let url = URL(string:"http://127.0.0.1:8000/")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = httpbody.data(using: .utf8)

        
        URLSession.shared.dataTask(with: request){
            data, response, error in print (response as Any)
            
            //if (error)
            
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            print("Data : \(data)")
            

            let reqResponse = try! JSONDecoder().decode(self.newpositions , from: data)
            
            self.Xposition = reqResponse.X
            self.Yposition = reqResponse.Y
            
            print("Response Body: \(reqResponse)")
            print("Response X value: \(reqResponse.X)")
        
        }.resume()
    }
    
}



/* First test version

func APIJOSNformat() -> String{
    
    
    var beacons = Beacons.self
    
    let JSONbeacons = """
    
    {
        "ID":"-12344567",
        "B1":"-102",
        "B2":"-85",
        "B3":"-24"
    }

    """
    
    return JSONbeacons
    
}

func REQUESTHandling()->[String]{
    
    
    let JSONdata : Data
    let data = JSONdata.data(using: .utf8)
    
    let parsingData = try! JSONDecoder().decode(Beacons, from: data)
    
    print("Beacons1 \(parsingData.Beacon1)")

    
    return [parsingData.Beacon1, parsingData.Beacon2, parsingData.Beacon3]

    
}

func dispInView(){
    
    
}
*/

//Struct allowing to updating the position

struct updatepositionView: View{
    var X : Float
    var Y : Float
    
    //@ObservedObject var BLEmanager = BLEManager()
    
    var B1X : Float = 0.0
    var B1Y : Float = 0.0
    var B2X : Float = 0.85
    var B2Y : Float = 1.1
    var B3X : Float = 1.2
    var B3Y : Float = 0.75
    
    var body: some View{
    
        //Text("Test BLE")
        
        VStack{
            
            if (abs(X - B1X ) < 0.1 || abs(Y - B1X) < 0.1) {
                Text("You are near the first monument").foregroundColor(.green)
            }
            else if(abs(X - B2X ) < 0.1 || abs(Y - B2X) < 0.1){
                Text("You are near the Second monument").foregroundColor(.orange)
            }
            else if (abs(X - B3X ) < 0.1 || abs(Y - B3X) < 0.1){
                Text("You are near the Third monument").foregroundColor(.blue)
            }
            else{
                Text("You are currently in the middle of the monuments")
            }
        }.padding(10)
        
    // Adding of of Zone condition
    }
}




struct ProfileText: View {
    @AppStorage("name") var name = DefaultSettings.name
    @AppStorage("subtitle") var subtitle = DefaultSettings.subtitle
    @AppStorage("description") var description = DefaultSettings.description
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                Text(name)
                    .bold()
                    .font(.title)
                Text(subtitle)
                    .font(.body)
                    .foregroundColor(.secondary)
            }.padding()
            
           //StatusView()
            
            /*
            VStack{
                Text("My App")
                Text("ID: ")
                Text("Buying date: ")
                Text("Last usage: ")
                Text("Numpber of usage: ")
            }*/

        }
    }
}





struct Header: View {
    @AppStorage("rValue") var rValue = 85.0//DefaultSettings.rValue
    @AppStorage("gValue") var gValue = 23.0//DefaultSettings.gValue
    @AppStorage("bValue") var bValue = 78.0//DefaultSettings.bValue
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(.blue)
                //.foregroundColor(Color(red: 85.0, green: 28.0, blue: 125.0, opacity: 1.0))
                .edgesIgnoringSafeArea(.top)
                .frame(height: 200)
            Image("Memoji_Talla")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
        }
    }
}


struct StatusView: View{
    
    @ObservedObject var BLEmanager : BLEManager
    
    var body: some View {
        
    VStack (spacing: 10) {

        Text("Bluetooth Devices")
            .frame(maxWidth: .infinity, alignment: .center)
        List(BLEmanager.peripheralsBest) {peripheral in HStack{
            Text(peripheral.name)
            Spacer()
            Text(String(peripheral.RSSI))
        }
            //Text("placeholder 1")
            //Text("placeholder 2")
        }.frame(height: 200)
        
    }
}
    
}
/*
struct StatusView: View {
    
    @State var BLEmanager : BLEManager

    
    var body: some View {
        HStack(alignment: .center) {
            /*
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .padding(.all, 20)
            */
            
            
            
            VStack(alignment: .leading) {
                Text("Global Status")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(20)
                
                VStack(alignment: .leading){
                    Text("ID: 1234556")
                    Text("Pseudo: ttal")
                    Text("Last using : ")
                    Text("Number of using : ")
                    Text("Total duration : ")
                }
                .padding(20)

                
                /*HStack {
                    Text("$" + String.init(format: "%0.2f", price))
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 8)
                }*/
            }.padding(.trailing, 20)
            Spacer()
        }
        .frame( maxWidth: .infinity, alignment: .center)
        .background(Color(red: 50/255, green: 200/255, blue: 120/255))
        //.modifier(CardModifier())
        .padding(.all, 20)
        .cornerRadius(70)
    }
}
*/
    
struct BLEappView_Previews: PreviewProvider {
    static var previews: some View {
        BLEappView()
    }
}
