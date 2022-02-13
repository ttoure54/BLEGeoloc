//
//  BLEconnectionView.swift
//  Bluetooth_app
//
//  Created by Talla Toure on 06/11/2021.
//
//
// Performing BLE connection 



import SwiftUI
import Foundation
import CoreBluetooth

struct BLEconnectionView: View {
    
    @ObservedObject var BLEmanager = BLEManager()

    var body: some View {
        
        VStack (spacing: 10) {

            Text("Bluetooth Devices")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
            List(BLEmanager.peripheralsBest) {peripheral in HStack{
                Text(peripheral.name)
                Spacer()
                Text(String(peripheral.RSSI))
            }
                //Text("placeholder 1")
                //Text("placeholder 2")
            }.frame(height: 300)

            Spacer()

            Text("STATUS")
                .font(.headline)

            // Status goes here
            if BLEmanager.switchedOn{
                Text("Bluetooth turned on")
                    .foregroundColor(.green)
            }else{
                Text("Bluetooth turned off")
                    .foregroundColor(.red)
            }
        
            //Text("Bluetooth status here")
                //.foregroundColor(.red)

            Spacer()

            HStack {
                VStack (spacing: 10) {
                    Button(action: {
                        self.BLEmanager.startScanning()
                        //print("Start Scanning")
                    }) {
                        Text("Start Scanning")
                    }
                    Button(action: {
                        self.BLEmanager.stopScanning()
                        //print("Stop Scanning")
                    }) {
                        Text("Stop Scanning")
                    }
                }.padding()

                Spacer()

                VStack (spacing: 10) {
                    Button(action: {
                        print("Start Advertising")
                    }) {
                        Text("Start Advertising")
                    }
                    Button(action: {
                        print("Stop Advertising")
                    }) {
                        Text("Stop Advertising")
                    }
                }.padding()
            }
            Spacer()
        }
    }
}

struct Peripheral : Identifiable{
    
    let id: Int
    let RSSI: Int
    let name : String
}



class BLEManager : NSObject, ObservableObject, CBCentralManagerDelegate{

    var myCentral : CBCentralManager!
    @Published var switchedOn = false
    @Published var peripherals = [Peripheral]()
    @Published var peripheralsBest = [Peripheral]()
    @Published var peripheralsBestRSSI = [0, 0, 0]
    
    
    override init(){
        
        super.init()
        
        myCentral = CBCentralManager(delegate: self, queue: nil )
        myCentral.delegate = self
    }
    
    
    func startScanning() {
        print("Start Scanning")
        myCentral.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func stopScanning() {
        print("Stop Scanning")
        myCentral.stopScan()
    }
    
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if central.state == .poweredOn{
            switchedOn = true
        }else{
            switchedOn = false
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        var peripheralName : String!
        var BestRSSI = [-200, -200, -200]
        
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            
            peripheralName = name
        }else{
            peripheralName = "UNKNOWN"
        }
        
        let newPeripheral = Peripheral(id: peripherals.count, RSSI: RSSI.intValue, name: peripheralName)
        
        if newPeripheral.RSSI > BestRSSI[0]{
            peripheralsBestRSSI[0] = BestRSSI[0]
            peripheralsBest.insert(newPeripheral, at: 0) //??peripheralsBest.append(BestRSSI[0])
        }else if(newPeripheral.RSSI > BestRSSI[1]){
            peripheralsBestRSSI[1] = BestRSSI[1]
            peripheralsBest.insert(newPeripheral, at: 1)
        }else if(newPeripheral.RSSI > BestRSSI[2]){
            peripheralsBestRSSI[2] = BestRSSI[2]
            peripheralsBest.insert(newPeripheral, at: 2)
        }
        print(newPeripheral)
        peripherals.append(newPeripheral)
    }
}

struct BLEconnectionView_Previews: PreviewProvider {
    static var previews: some View {
        BLEconnectionView()
    }
}
