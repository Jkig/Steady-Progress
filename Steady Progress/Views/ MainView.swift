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
                GroupBox{
                    Chart (settingsViewModel.showSmooth ? viewModel.smoothData : viewModel.data) {
                        LineMark(
                            x: .value("Month", $0.date),
                            y: .value("Weight", $0.weight)
                        )
                        // maybe add option to show unsmoothed data
                        if settingsViewModel.showGoal {
                            RuleMark(y: .value("goal", viewModel.goal))
                                .foregroundStyle(.red)
                        }
                            
                    }
                    .frame(height:400)
                    .chartYScale(domain: Int(viewModel.minVal)...Int(viewModel.maxVal), type: nil)
                }
                .padding([.bottom])
                
                if viewModel.data.count > viewModel.daysToSmooth{
                    HStack{
                        Text("Estimated True Weight")
                            .font(.system(size:12))
                            .offset(y: 7)
                        
                        Spacer()
                        
                        Text(String(format: "%.1f", viewModel.smoothData.last!.weight))
                            .font(.system(size:35))
                        
                        Text(String(format: "%.1f", viewModel.smoothData.last!.weight-viewModel.startWeight))
                            .foregroundColor(((settingsViewModel.selection == "Loose weight" && (viewModel.smoothData.last!.weight-viewModel.startWeight) <= 0) || ((settingsViewModel.selection == "Gain weight" && (viewModel.smoothData.last!.weight-viewModel.startWeight) >= 0))) ? .green : .black)
                            .font(.system(size:20))
                            .offset(y: 5)
                        
                    }
                    .padding([.leading, .trailing])
                }
                else{
                    Text("Estimated True Weight and total change are calculated when you hit \(viewModel.daysToSmooth) measurements!")
                        .font(.system(size:20))
                        .offset(y: 7)
                        .padding()
                }
                
                Spacer()
                
                if environmentView.keyboardIsPresented {
                    // Display Toolbar View
                    HStack(alignment: .center) {
                        Button {
                            keyBoardClose()
                        } label: {
                            Text("Cancel")
                        }
                        .padding(8)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        
                        Text(text)
                            .padding()
                        Spacer()
                        
                        Button {
                            //viewModel.addMeasurement(weightSTR: text)
                            keyBoardCloseWrite()
                            environmentView.keyboardIsPresented = false
                        } label: {
                            Text("Add")
                        }
                        .padding(8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width, height: 35)
                }
                
                HStack {
                    
                    NavigationLink("Edit Old", destination: EditView(data:viewModel.data))
                    
                    TextField("Measurment", text: $text)
                        .keyboardType(.decimalPad)
                        .padding()
                }
            }
            .padding()
            .onReceive(keyboardPublisher) { presented in
                environmentView.keyboardIsPresented = presented
                text = ""
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Too soon"),
                      message: Text("Results take time, please wait until tomorrow to measure again :)"),
                      dismissButton: .default(Text("OK")))
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


