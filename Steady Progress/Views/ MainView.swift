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


struct model: Identifiable {
    var id: UUID
    var date: Int
    var weight: Float
    
    init(date:Int, weight:Float) {
        self.id = UUID()
        self.date = date
        self.weight = weight
    }
}

struct MainView: View {
    @State var keyboardIsPresented: Bool = false
    @State private var text = ""
    
    // test data:
    var weights: [Float] = [188.4, 184.5, 184.6, 185.7, 180.0, 179.4, 185.0, 181.0, 186.0, 178.7, 179.6, 186.0, 179.9, 183.6, 186.4, 182.0, 180.3, 182.7, 181.2, 179.8, 181.6, 183.1, 176.4, 179.7, 181.6, 180.5, 176.2, 174.4, 175.1, 178.1, 174.6, 180.3, 182.0, 176.2, 176.9, 179.4, 174.7, 180.5, 181.7, 180.2, 176.2, 175.9, 174.3, 177.4, 174.3, 180.6, 175.0, 174.9, 176.0, 170.1, 170.1, 172.0, 175.2, 169.4, 177.7, 177.2, 174.0, 174.2, 171.6, 176.0, 176.1, 172.3, 169.8, 168.6, 167.7, 173.3, 170.7, 173.8, 174.0, 170.0, 173.6, 173.2, 174.4, 168.1, 174.8, 174.3, 166.8, 172.9, 171.3, 168.5, 168.8, 166.5, 165.2, 169.9, 167.2, 169.7, 168.1, 167.7, 169.4, 170.8, 162.5, 164.7, 163.1, 165.3, 163.1, 164.4, 162.2, 169.1, 163.3, 169.2]
    
    
    
    var data: [model] {
        weights.enumerated().map { index, weight in
            model(date: index + 1, weight: weight)
        }
    }
    // build smooth data from data,
    
    
    // set much better in time, probs just local store as variables and recalc on every new point user adds:
    
    var minVal = false ? 150 : min(150, 175)
    var maxVal = 200
    var trueWeight = 162.2
    
    var goal = 160
    
    
    var body: some View {
        NavigationView{
            VStack {
                GroupBox{
                    Chart(data) {
                        LineMark(
                            x: .value("Month", $0.date),
                            y: .value("Weight", $0.weight)
                        )
                        // graph smoothed data
                        
                        
                        RuleMark(y: .value("goal", goal))
                            .foregroundStyle(.red)
                    }
                    .frame(height:400)
                    .chartYScale(domain: minVal...maxVal, type: nil)
                }
                .padding([.bottom])
                
                HStack{
                    Spacer()
                    
                    Text(String(format: "%.1f", trueWeight))
                        .font(.system(size:35))
                    
                    Text("Estimated True Weight")
                        .font(.system(size:12))
                        .offset(y: 7)
                }
                
                Spacer()
                
                if keyboardIsPresented {
                    // Display Toolbar View
                    HStack(alignment: .center) {
                        Button {
                            // Dismiss keyboard
                            UIApplication.shared.sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil,
                                from: nil,
                                for: nil
                            )
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
                            // Dismiss keyboard
                            UIApplication.shared.sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil,
                                from: nil,
                                for: nil
                            )
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
                    
                    NavigationLink("Edit Old", destination: EditView(data:data))
                    
                    TextField("Measurment", text: $text)
                        .keyboardType(.decimalPad)
                        .padding()
                }
            }
            .padding()
            .onReceive(keyboardPublisher) { presented in
                self.keyboardIsPresented = presented
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
