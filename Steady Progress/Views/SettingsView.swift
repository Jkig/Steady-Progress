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
    @EnvironmentObject var environmentView: EnvironmentViewModel
    
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
                        HStack {
                            Toggle(isOn: $viewModel.showGoal) {
                                Text("Show Goal")
                            }
                            .onChange(of: viewModel.showGoal) { _ in
                                viewModel.storeSettings()
                                environmentView.reset = UUID()
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                        .padding()
                        
                        HStack {
                            Toggle(isOn: $viewModel.showSmooth) {
                                Text("Smoothed Measurements:")
                            }
                            .onChange(of: viewModel.showSmooth) { _ in
                                viewModel.storeSettings()
                                environmentView.reset = UUID()
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                        .padding()
                        
                        HStack{
                            Text("Goal Direction")
                            Spacer()
                            Picker("Select a Direction", selection: $viewModel.selection) {
                                ForEach(["Lose weight", "Maintain weight", "Gain weight"], id: \.self) {
                                    Text($0)
                                }
                            }
                            .onChange(of: viewModel.selection) { _ in
                                viewModel.storeSettings()
                                environmentView.reset = UUID()
                            }
                            .pickerStyle(.menu)
                        }
                        .padding([.top, .leading, .bottom])
                        .padding(.trailing, 4)
                        
                        HStack{
                            Text("Goal Weight")
                            Spacer()
                            TextField("Goal", value: $mainViewModel.goal, format: .number)
                                .keyboardType(.decimalPad)
                                .frame(width: 75)
                                .multilineTextAlignment(.trailing)
                                .onSubmit {
                                    setGoalWeight()
                                    environmentView.reset = UUID()
                                }
                        }
                        .padding()
                        
                        
                        Button(action:{
                            environmentView.keyboardIsPresented = false
                            
                        }, label:{
                                NavigationLink("Disclosures and Methodologies", destination: Disclosures_and_Methodologies())
                            })
                            .padding(8)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }
                }
                if environmentView.keyboardIsPresented {
                        // Display Toolbar View
                        HStack(alignment: .center) {
                            Spacer()
                            Button {
                                setGoalWeight()
                                environmentView.reset = UUID()
                            } label: {
                                Text("Set")
                            }
                            .padding(8)
                            //.background(Color.blue)
                            //.foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding()
                        .frame(height: 35)
                    }
                }
                .padding([.top, .leading, .trailing])
            }
            .onReceive(keyboardPublisher) { presented in
                environmentView.keyboardIsPresented = presented
            }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static let environmentVariable = EnvironmentViewModel()
    
    static var previews: some View {
        SettingsView()
            .environmentObject(environmentVariable)
    }
}
