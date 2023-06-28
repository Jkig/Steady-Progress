//
//  ContentView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/11/23.
//
import SwiftUI
import Charts



struct ContentView: View {
    @StateObject var viewModel = EnvironmentViewModel()
    @State private var selectedTab = 0
    @State var goal: Float = 0
    
    var body: some View {
        TabView (selection: $selectedTab) {
            MainView()
                .environmentObject(viewModel)
                .tabItem {
                    Image(systemName: "scalemass")
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tag(0)

            SettingsView()
                .environmentObject(viewModel)
                .tabItem {
                    Image(systemName: "gear")
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tag(1)
        }
        .id(viewModel.reset)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

