//
//  ContentView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/11/23.
//
import SwiftUI
import Charts



struct ContentView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView (selection: $selectedTab) {
            Page1View()
                .tabItem {
                    Image(systemName: "map")
                }
                .tag(0)

            main()
                .tabItem {
                    Image(systemName: "scalemass")
                }
                .tag(1)

            settings()
                .tabItem {
                    Image(systemName: "gear")
                }
                .tag(2)
        }
    }
}

struct Page1View: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Set goals and stuff here")
        }
    }
}

struct main: View {
    @State private var text = ""
    
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
    
    // test data:
    var weights: [Float] = [188.4, 184.5, 184.6, 185.7, 180.0, 179.4, 185.0, 181.0, 186.0, 178.7, 179.6, 186.0, 179.9, 183.6, 186.4, 182.0, 180.3, 182.7, 181.2, 179.8, 181.6, 183.1, 176.4, 179.7, 181.6, 180.5, 176.2, 174.4, 175.1, 178.1, 174.6, 180.3, 182.0, 176.2, 176.9, 179.4, 174.7, 180.5, 181.7, 180.2, 176.2, 175.9, 174.3, 177.4, 174.3, 180.6, 175.0, 174.9, 176.0, 170.1, 170.1, 172.0, 175.2, 169.4, 177.7, 177.2, 174.0, 174.2, 171.6, 176.0, 176.1, 172.3, 169.8, 168.6, 167.7, 173.3, 170.7, 173.8, 174.0, 170.0, 173.6, 173.2, 174.4, 168.1, 174.8, 174.3, 166.8, 172.9, 171.3, 168.5, 168.8, 166.5, 165.2, 169.9, 167.2, 169.7, 168.1, 167.7, 169.4, 170.8, 162.5, 164.7, 163.1, 165.3, 163.1, 164.4, 162.2, 169.1, 163.3, 169.2]
        
    
    
    var data: [model] {
        weights.enumerated().map { index, weight in
            model(date: index + 1, weight: weight)
        }
    }
    
    // set much better in time, probs just local store as variables and recalc on every new point user adds:
    
    var minVal = 150
    var maxVal = 200
    var trueWeight = 182.5
    

    var body: some View {
        VStack {
            GroupBox ("Weight over time"){
                Chart(data) {
                    LineMark(
                        x: .value("Month", $0.date),
                        y: .value("Weight", $0.weight)
                    )
                }
                .frame(height:400)
                .chartYScale(domain: minVal...maxVal, type: nil)
            }
            .padding()
            
            HStack{
                Text("True Weight:")
                .font(.system(size:30))
                
                Text(String(format: "%.1f", trueWeight))
                .font(.system(size:30))
            }
            
            HStack {
                TextField("Enter text", text: $text)
                    .padding()
                    .border(Color.gray, width: 0.5)
                
                Button(action: {
                    print(text)
                }) {
                    Text("Add")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

struct settings: View {
    @State private var isKilograms = false
    @State private var showGoal = false
    @State private var showGoalLine = false
    
    var body: some View {
        VStack{
            Text("Settings page")
            
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
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


