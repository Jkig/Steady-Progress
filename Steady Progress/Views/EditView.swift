//
//  EditView.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/20/23.
//

import SwiftUI

struct EditView: View {
    let data: [Model]
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
        EditView(data: [Model(id: 1, date: Date(), weight: 140), Model(id: 2, date: Date(), weight: 150)])
    }
}
