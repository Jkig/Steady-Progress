//
//  MeasurementView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/20/23.
//

import SwiftUI

struct MeasurementView: View {
    let measurement:Model
    @StateObject var viewModel = MainViewModel()
    @EnvironmentObject var environmentView: EnvironmentViewModel
    
    
    var body: some View {
        HStack{
            Text(measurement.date, style: .date)
            Spacer()
            Text(String(format: "%.1f", measurement.weight))
            Spacer()
            Button(action: {
                viewModel.deleteOld(index: measurement.id)
                environmentView.reset = UUID()
            }) {
                Text("Delete")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding([.leading,.trailing])
    }
}

struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        // with sample data
        MeasurementView(measurement: Model(id:1, date: Date(), weight: 180))
    }
}
