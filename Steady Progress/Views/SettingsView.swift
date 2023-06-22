//
//  SettingsView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/19/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    @StateObject var mainViewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView {
                    VStack {
                        /*
                        HStack {
                            Spacer()
                            Toggle(isOn: $viewModel.isKilograms) {
                                Text("Use KG")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                            Spacer()
                        }
                        .padding()
                        */
                        HStack {
                            Spacer()
                            Toggle(isOn: $viewModel.showGoal) {
                                Text("Show Goal")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                            Spacer()
                        }
                        .padding()
                        /*
                        // goal for weight change line
                        HStack {
                            Spacer()
                            Toggle(isOn: $viewModel.showGoalLine) {
                                Text("Show Goal Line")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                            Spacer()
                        }
                        .padding()
                         */
                        HStack {
                            Spacer()
                            Toggle(isOn: $viewModel.showBMI) {
                                Text("BMI")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                            Spacer()
                        }
                        .padding()
                        
                        HStack {
                            Spacer()
                            Toggle(isOn: $viewModel.showSmooth) {
                                Text("Smoothed Measurements:")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                            Spacer()
                        }
                        .padding()
                        HStack{
                            Spacer()
                            Text("Goal Direction")
                            Spacer()
                            Picker("Select a paint color", selection: $viewModel.selection) {
                                ForEach(viewModel.direction, id: \.self) {
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
                            TextField("Enter Value", value: $mainViewModel.goal, format: .number)
                                .keyboardType(.decimalPad)
                                .padding([.leading, .trailing])
                        }
                        .padding()
                        
                        
                        VStack{
                            Button(action:{}, label:{
                                NavigationLink("Set Personal Data", destination: PersonalInfoView())
                            })
                            .padding(8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            
                            HStack{
                                
                                Text("Age: 50")
                                
                                Text("Height: 50")
                                
                                if viewModel.showBMI{
                                    Text("BMI: \(String(format: "%.1f", mainViewModel.data.last!.weight/pow(Float(viewModel.heightFeet * 12 + viewModel.heightInches),2)*703))")
                                }
                            }
                            // Could say what the BMI means, but probably not really helpful, may pull it all as well as the personal data  entirely
                            // Text("Passive caloric Burn: 2000")
                        }
                        Spacer()
                    }}
                if mainViewModel.keyboardIsPresented {
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
                
            
            }
            .padding()
            .onReceive(keyboardPublisher) { presented in
                mainViewModel.keyboardIsPresented = presented
            }
        
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
