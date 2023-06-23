//
//  SettingsView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/19/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var mainViewModel = MainViewModel()
    @StateObject var viewModel = SettingsViewModel()
    // @State var keyboardIsPresented:Bool = false
    @EnvironmentObject var environmentView: KeyboardViewModel
    
    func setGoalWeight() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        );
        mainViewModel.setGoal(newGoal: mainViewModel.goal)
        environmentView.keyboardIsPresented = false
    }
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView {
                    VStack {
                        /*
                        HStack {
                            Toggle(isOn: $viewModel.isKilograms) {
                                Text("Use KG")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                        .padding()
                        */
                        HStack {
                            Toggle(isOn: $viewModel.showGoal) {
                                Text("Show Goal")
                            }
                            .onChange(of: viewModel.showGoal) { _ in
                                viewModel.storeSettings()
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                        .padding()
                        /*
                        // goal for weight change line
                        HStack {
                            Toggle(isOn: $viewModel.showGoalLine) {
                                Text("Show Goal Line")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                        .padding()
                        */
                        /*
                        HStack {
                            Toggle(isOn: $viewModel.showBMI) {
                                Text("BMI")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                        .padding()
                         
                        */
                        
                        HStack {
                            Toggle(isOn: $viewModel.showSmooth) {
                                Text("Smoothed Measurements:")
                            }
                            .onChange(of: viewModel.showSmooth) { _ in
                                viewModel.storeSettings()
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                        .padding()
                        HStack{
                            Text("Goal Direction")
                            Spacer()
                            Picker("Select a Direction", selection: $viewModel.selection) {
                                ForEach(viewModel.direction, id: \.self) {
                                    Text($0)
                                }
                            }
                            .onChange(of: viewModel.selection) { _ in
                                viewModel.storeSettings()
                            }
                            .pickerStyle(.menu)
                        }
                        .padding()
                        
                        HStack{
                            Text("Goal Weight")
                                .padding([.trailing])
                            Spacer()
                                .padding([.trailing])
                            TextField("Enter Value", value: $mainViewModel.goal, format: .number)
                                .keyboardType(.decimalPad)
                                .frame(width: 40)
                        }
                        .padding()
                        
                        /*
                        // personal info section
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
                                    if !mainViewModel.data.isEmpty{
                                        Text("BMI: \(String(format: "%.1f", mainViewModel.data.last!.weight/pow(Float(viewModel.heightFeet * 12 + viewModel.heightInches),2)*703))")
                                    }
                                }
                            }
                            // Could say what the BMI means, but probably not really helpful, may pull it all as well as the personal data  entirely
                            // Text("Passive caloric Burn: 2000")
                        }
                         */
                        
                    }}
                if environmentView.keyboardIsPresented {
                        // Display Toolbar View
                        HStack(alignment: .center) {
                            Spacer()
                            Button {
                                setGoalWeight()
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
                environmentView.keyboardIsPresented = presented
            }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
