//
//  Settings_profileView.swift
//  Bluetooth_app
//
//  Created by Talla Toure on 28/10/2021.
//

import SwiftUI

struct Settings_profileView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                HeaderBackgroundSliders()
                ProfileSettings()
            }
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(
                trailing:
                    Button (
                        action: {
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Text("Done")
                        }
                    )
            )
        }
    }
}
struct ProfileSettings: View {
    @AppStorage("name") var name = DefaultSettings.name
    @AppStorage("subtitle") var subtitle = DefaultSettings.subtitle
    @AppStorage("description") var description = DefaultSettings.description
    
    var body: some View {
        Section(header: Text("Profile")) {
            Button (
                action: {
                    // Action
                },
                label: {
                    Text("Pick Profile Image")
                }
            )
            TextField("Name", text: $name)
            TextField("Subtitle", text: $subtitle)
            TextEditor(text: $description)
        }
    }
}



struct HeaderBackgroundSliders: View {
    @AppStorage("rValue") var rValue = 84.0//DefaultSettings.rValue
    @AppStorage("gValue") var gValue = 76.5//DefaultSettings.gValue
    @AppStorage("bValue") var bValue = 23.9//DefaultSettings.bValue
    
    var body: some View {
        Section(header: Text("Header Background Color")) {
            HStack {
                VStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100)
                        .foregroundColor(Color(red: rValue, green: gValue, blue: bValue, opacity: 1.0))
                }
                //                VStack {
                //                    Text("R: \(Int(rValue * 255.0))")
                //                    Text("G: \(Int(gValue * 255.0))")
                //                    Text("B: \(Int(bValue * 255.0))")
                //                }
                /*VStack {
                    colorSlider(value: $rValue, textColor: .red)
                    colorSlider(value: $gValue, textColor: .green)
                    colorSlider(value: $bValue, textColor: .blue)
                }*/
            }
        }
    }
}

struct colorSlider: View {
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        HStack {
            Text(verbatim: "0")
                .foregroundColor(textColor)
            Slider(value: $value, in: 0.0...1.0)
            Text(verbatim: "255")
                .foregroundColor(textColor)
            
        }
    }
}



struct Settings_profileView_Previews: PreviewProvider {
    static var previews: some View {
        Settings_profileView()
    }
}
