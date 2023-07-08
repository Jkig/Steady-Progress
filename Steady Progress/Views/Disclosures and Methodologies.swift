//
//  Disclosures and Methodologies.swift
//  Steady Progress
//
//  Created by Derek Leroux on 7/4/23.
//

import SwiftUI

struct Disclosures_and_Methodologies: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack{
                        Text("Notes about methodologies")
                            .font(.system(size:25))
                            .bold()
                            .padding([.trailing], 2)
                        Spacer()
                    }
                    Spacer()
                    
                    HStack {
                        Text(" • Smoothing means that the data point will be the average of that measurement as well as the preceeding 13 measurements.")
                            .padding([.leading], 10)
                            .padding([.top],2)
                        Spacer()
                    }
                    
                    HStack {
                        Text(" • If smoothing is turned off the graph will just connect the measurements with straight lines")
                            .padding([.leading], 10)
                            .padding([.top],2)
                        Spacer()
                    }
                    HStack {
                        Text(" • The first 14 measruements are the average of all measruements up to that point")
                            .padding([.leading], 10)
                            .padding([.top],2)
                        Spacer()
                    }
                    HStack {
                        Text(" • The Recent Average Weight is the average of the last 14 mearuements.")
                            .padding([.leading], 10)
                            .padding([.top],2)
                        Spacer()
                    }
                }
                Spacer()
                    .padding()
            }
        Text("See a doctor before making any changes that may impact you health.")
            .font(.system(size:12))
            .bold()
            .multilineTextAlignment(.center)
        }
        .padding([.leading,.trailing])
    }
}

struct Disclosures_and_Methodologies_Previews: PreviewProvider {
    static var previews: some View {
        Disclosures_and_Methodologies()
    }
}
