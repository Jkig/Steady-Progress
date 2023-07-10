//
//   MainView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/19/23.
//

import SwiftUI
import Charts
import Combine


extension View {
var keyboardPublisher: AnyPublisher<Bool, Never> {
    Publishers
        .Merge(
            NotificationCenter
                .default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            NotificationCenter
                .default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false })
        .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
        .eraseToAnyPublisher()
}}


struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    
    @EnvironmentObject var environmentView: EnvironmentViewModel
    @State private var text = ""
    
    func keyBoardClose(){
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        );
    }
     
    func keyBoardCloseWrite(){
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        );
        viewModel.addMeasurement(weightSTR: text)
        environmentView.keyboardIsPresented = false
        text = ""
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        chartView(data:settingsViewModel.showSmooth ? viewModel.smoothData : viewModel.data, goal: viewModel.goal, minVal: viewModel.minVal,maxVal: viewModel.maxVal,showGoal: settingsViewModel.showGoal)
                        
                        
                        if viewModel.data.count > viewModel.daysToSmooth{
                            HStack{
                                Text("Recent Average Weight")
                                    .font(.system(size:12))
                                    .offset(y: 7)
                                
                                Spacer()
                                
                                Text(String(format: "%.1f", viewModel.smoothData.last!.weight))
                                    .font(.system(size:35))
                                /*
                                 Text(String(format: "%.1f", viewModel.smoothData.last!.weight-viewModel.startWeight))
                                 .foregroundColor(((settingsViewModel.selection == "Lose weight" && (viewModel.smoothData.last!.weight-viewModel.startWeight) <= 0) || ((settingsViewModel.selection == "Gain weight" && (viewModel.smoothData.last!.weight-viewModel.startWeight) >= 0))) ? .green : .black)
                                 .font(.system(size:20))
                                 .offset(y: 5)
                                 */
                            }
                            .padding([.leading, .trailing])
                        } else{
                            Text("More data at \(viewModel.daysToSmooth) measurements!")
                                .font(.system(size:20))
                                .offset(y: 7)
                                .padding()
                        }
                        
                        Spacer()
                            .padding()
                        

                        HStack {
                            if environmentView.keyboardIsPresented {
                                Button {
                                    keyBoardClose()
                                } label: { Text("Cancel") }
                                    .padding(8)
                                    //.background(Color.red)
                                    //.foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            else {
                                NavigationLink("Edit Old", destination: EditView(data:viewModel.data))
                            }
                            TextField("Measurment", text: $text)
                                .keyboardType(.decimalPad)
                                .padding()
                                .onSubmit {
                                    keyBoardCloseWrite()
                                    environmentView.keyboardIsPresented = false
                                }
                            if environmentView.keyboardIsPresented {
                                Button {
                                    keyBoardCloseWrite()
                                    environmentView.keyboardIsPresented = false
                                } label: { Text("Add") }
                                    .padding(8)
                                    //.background(Color.blue)
                                    //.foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                        }//hstack
                        .frame(height: 35)
                    }//Vstack
                }//scroll
                .padding([.top, .leading, .trailing])
                .onReceive(keyboardPublisher) { presented in
                    environmentView.keyboardIsPresented = presented
                    text = ""
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text(viewModel.alertTitle),
                          message: Text(viewModel.alertText),
                          dismissButton: .default(Text("OK")))
                }
            }//vstack
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static let environmentVariable = EnvironmentViewModel()
    
    static var previews: some View {
        MainView()
            .environmentObject(environmentVariable)
    }
}


