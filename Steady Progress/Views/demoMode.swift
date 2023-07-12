//
//  demoMode.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/27/23.
//

import SwiftUI

struct demoMode: View {
    @StateObject var viewModel = MainViewModel()
    @EnvironmentObject var environmentView: EnvironmentViewModel
    
    var body: some View {
        VStack{
            Text("Viewing Demo data will delete current data and reset to demo data")
            HStack {
                Button(action:{
                    /*
                    viewModel.setupDemo(weights:[183.43, 187.96, 183.19, 188.52, 180.55, 186.98, 180.81, 188.34, 185.97, 180.7, 184.93, 188.96, 187.49, 185.22, 183.75, 183.08, 187.51, 181.84, 183.87, 184.4, 180.73, 186.06, 183.79, 185.72, 187.05, 189.58, 188.31, 185.94, 186.07, 189.9, 189.03, 183.06, 188.59, 190.92, 182.95, 188.48, 189.41, 187.14, 187.17, 182.4, 184.03, 182.66, 182.69, 181.72, 191.15, 189.48, 181.51, 188.74, 189.27, 189.8, 182.43, 185.46, 191.29, 182.22, 186.75, 191.48, 186.61, 190.24, 187.27, 191.7, 182.83, 186.86, 189.79, 189.02, 188.65, 187.18, 184.51, 191.64, 186.77, 186.3, 185.03, 190.86, 185.49, 188.32, 191.15, 191.38, 188.81, 183.14, 187.87, 188.3, 189.33, 191.06, 184.19, 183.22, 190.15, 191.08, 183.81, 189.24, 183.07, 192.0, 192.43, 189.26, 190.39, 189.42, 183.85, 187.08, 186.21, 190.14, 189.77, 187.6], start:185.1)
                     */
                    environmentView.reset = UUID()
                }, label:{
                    Text("Demo Data 1")
                })
                .padding(10)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button(action:{
                    /*
                    viewModel.setupDemo(weights:[187.0, 182.7, 184.4, 185.6, 187.5, 187.4, 185.9, 187.1, 181.1, 184.4, 186.5, 181.2, 184.7, 182.1, 184.9, 183.9, 183.7, 182.6, 181.0, 181.5, 184.1, 180.4, 181.2, 185.5, 184.4, 181.0, 181.1, 185.1, 183.6, 183.1, 184.2, 182.8, 183.8, 183.5, 181.0, 180.7, 184.3, 184.1, 183.3, 182.5, 183.2, 177.9, 181.9, 178.9, 178.9, 181.7, 179.8, 181.8, 180.1, 178.6, 179.4, 182.2, 180.1, 182.1, 181.9, 178.2, 178.7, 180.8, 176.7, 182.0, 179.8, 178.5, 180.8, 177.1, 175.7, 177.0, 179.7, 176.4, 177.9, 177.3, 177.9, 175.2, 180.3, 178.7, 179.4, 175.8, 179.2, 174.5, 174.5, 178.7, 176.3, 176.9, 179.7, 179.4, 174.9, 177.5, 178.2, 176.8, 174.2, 173.7, 178.2, 177.0, 177.1, 175.3, 177.9, 174.3, 174.7, 174.7, 174.4, 173.8], start:184.8)
                     */
                    environmentView.reset = UUID()
                }, label:{
                    Text("Demo Data 2")
                })
                .padding(10)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            Button(action:{
                // viewModel.resetStored()
                environmentView.reset = UUID()
            }, label:{
                   Text("Delete all data")
                })
                .padding(10)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct demoMode_Previews: PreviewProvider {
    static var previews: some View {
        demoMode()
    }
}
