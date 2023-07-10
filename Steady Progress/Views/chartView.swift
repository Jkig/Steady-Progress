//
//  chartView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 7/10/23.
//

import SwiftUI
import Charts

struct chartView: View {
    var data: [Model]
    var goal: Double
    var minVal: Double
    var maxVal: Double
    var showGoal: Bool
    
    var body: some View {
        GroupBox{
            Chart (data) {
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Weight", $0.weight)
                )
                if showGoal {
                    RuleMark(y: .value("goal", goal))
                        .foregroundStyle(.red)
                }
            }
            .frame(height:400)
            .chartYScale(domain: Int(minVal)...Int(maxVal), type: nil)
        }
        .padding([.bottom])
    }
}

struct chartView_Previews: PreviewProvider {
    static var previews: some View {
        let data:[Model] = []
        
        chartView(data:data,goal:150,minVal: 130,maxVal: 150,showGoal: true)
    }
}
