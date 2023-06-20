//
//  ContentView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/11/23.
//
import SwiftUI
import Charts



struct ContentView: View {
    @State private var selectedTab = 0
    @State var goal: Float = 0
    
    var body: some View {
        TabView (selection: $selectedTab) {
            MainView()
                .tabItem {
                    Image(systemName: "scalemass")
                }
                .tag(0)

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                }
                .tag(1)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

