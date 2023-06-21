//
//  SettingsView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/19/23.
//

import SwiftUI

struct SettingsView: View {
    @State var keyboardIsPresented: Bool = false
    
    @State private var isKilograms = false
    @State private var showGoal = true
    @State private var showGoalLine = true
    @State private var showSmooth = true
    @State private var selection = "Loose weight"
    let direction = ["Loose weight", "Maintain weight", "Gain weight"]
    @State private var goalWeight: Float = 0
    
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Toggle(isOn: $isKilograms) {
                    Text("Use KG")
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                Spacer()
            }
            .padding()
            HStack {
                Spacer()
                Toggle(isOn: $showGoal) {
                    Text("Show Goal")
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                Spacer()
            }
            .padding()
            HStack {
                Spacer()
                Toggle(isOn: $showGoalLine) {
                    Text("Show Goal Line")
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                Spacer()
            }
            .padding()
            HStack {
                Spacer()
                Toggle(isOn: $showSmooth) {
                    Text("Show Smoothed Measurements:")
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                Spacer()
            }
            .padding()
            HStack{
                Spacer()
                Text("Goal Direction")
                Spacer()
                Picker("Select a paint color", selection: $selection) {
                    ForEach(direction, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                Spacer()
            }
            .padding()
            HStack{
                Spacer()
                Text("Goal Weight")
                    .padding([.trailing])
                Spacer()
                    .padding([.trailing])
                TextField("Enter Value", value: $goalWeight, format: .number)
                    .keyboardType(.decimalPad)
                    .padding([.leading, .trailing])
            }
            .padding()
            Spacer()
            if keyboardIsPresented {
                // Display Toolbar View
                HStack(alignment: .center) {
                    Spacer()
                    Button {
                        // Dismiss keyboard
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )
                    } label: {
                            Text("Set")
                    }
                    .padding(8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width, height: 35)
            }
        }
        .padding()
        .onReceive(keyboardPublisher) { presented in
            self.keyboardIsPresented = presented
        }
            
        }
    }


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
