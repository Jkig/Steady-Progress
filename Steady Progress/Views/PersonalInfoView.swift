//
//  PersonalInfoView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/21/23.
//

import SwiftUI

struct PersonalInfoView: View {
    @State private var heightFeet:Int = 0
    @State private var heightInch:Int = 0
    @State private var age:Int = 0
    
    var body: some View {
        VStack{
            HStack{
                Text("Select height feet")
                Picker(selection: $heightFeet, label: Text("Select a number")) {
                    ForEach(0..<12) { number in
                        Text("\(number)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            HStack{
                Text("Select height inches")
                Picker(selection: $heightInch, label: Text("Select a number")) {
                    ForEach(0..<12) { number in
                        Text("\(number)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            HStack{
                Text("Select Age")
                Picker(selection: $age, label: Text("Select a number")) {
                    ForEach(0..<100) { number in
                        Text("\(number)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }

        }
        .padding()
    }
}

struct PersonalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoView()
    }
}
