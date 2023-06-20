//
//  EditView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/20/23.
//

import SwiftUI

struct EditView: View {
    let data: [model]
    var body: some View {
        ScrollView{
            VStack (spacing: 20) {
                ForEach(data) { model in
                        MeasurementView(MWeight: model.weight, MDate: model.date)
                    }
                
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(data: [model(date: 1, weight: 140),model(date: 2, weight: 150)])
    }
}
