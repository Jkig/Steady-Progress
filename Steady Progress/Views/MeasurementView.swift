//
//  MeasurementView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/20/23.
//

import SwiftUI

struct MeasurementView: View {
    let MWeight: Float
    let MDate: Int // change to my own type
    
    
    var body: some View {
        HStack{
            Text("Date: \(MDate)")
            Spacer()
            Text(String(format: "%.1f", MWeight))
            Spacer()
            Button(action: {
                // delete only, edit probably encurages bad behavior for users lol
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
        MeasurementView(MWeight: 180, MDate: 1)
    }
}
