//
//  recentAverage.swift
//  Steady Progress
//
//  Created by Derek Leroux on 7/15/23.
//

import SwiftUI

struct recentAverage: View {
    let change: Double
    let weight: Double
    let direction: String
    let show: Bool
    let days: Int
    
    var body: some View {
        if show {
            HStack{
                Text("Recent Average Weight")
                    .font(.system(size:12))
                    .offset(y: 7)
                
                Spacer()
                
                Text(String(format: "%.1f", weight))
                    .font(.system(size:35))
                
                // let change = viewModel.smoothData.last!.weight-viewModel.startWeight
                
                Text(String(format: "%.1f", change))
                    .foregroundColor(((direction == "Lose weight" && change <= 0) || ((direction == "Gain weight" && change >= 0))) ? .green : .gray)
                    .font(.system(size:20))
                    .offset(y: 5)
                
            }
            .padding([.leading, .trailing])
        } else {
                Text("More data at \(days) measurements!")
                    .font(.system(size:20))
                    .offset(y: 7)
                    .padding()
        }
    }
}

struct recentAverage_Previews: PreviewProvider {
    static var previews: some View {
        recentAverage(change: -10, weight: 150, direction: "lose weight", show: true, days: 14)
    }
}
