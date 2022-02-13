//
//  ContentView.swift
//  Bluetooth_app
//
//  Created by Talla Toure on 24/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BLEappView()
        //BLEconnectionView()
        //Text("Hello, world!")
            //.padding()
    
            /*
            Button(action: {print("pressed")},
                   label : { Image("BTNpower")}
            ).frame(width: 100, height: 100)
       
        
        VStack {
            
                   VStack {
                   
                   // 2
                   //Text(viewModel.output)
                       Text("Hello, world!")
                       .frame(width: 300,
                              height: 50,
                              alignment: .trailing)
                       .font(.title)
                       .background(Color.gray.opacity(0.2))
                       .padding(.bottom)
    
        
                   // 3
                   //KeypadView(viewModel: viewModel)

                   // 4
                   //ConnectButtonView(viewModel: viewModel)
                   
                   }
               }*/
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
