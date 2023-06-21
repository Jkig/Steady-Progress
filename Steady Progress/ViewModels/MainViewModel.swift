//
//  MainViewModel.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/21/23.
//

import Foundation


class MainViewModel: ObservableObject {
    @Published var keyboardIsPresented: Bool = false
    
    // test data: setup here and on basically
    @Published var weights: [Float] = [188.4, 184.5, 184.6, 185.7, 180.0, 179.4, 185.0, 181.0, 186.0, 178.7, 179.6, 186.0, 179.9, 183.6, 186.4, 182.0, 180.3, 182.7, 181.2, 179.8, 181.6, 183.1, 176.4, 179.7, 181.6, 180.5, 176.2, 174.4, 175.1, 178.1, 174.6, 180.3, 182.0, 176.2, 176.9, 179.4, 174.7, 180.5, 181.7, 180.2, 176.2, 175.9, 174.3, 177.4, 174.3, 180.6, 175.0, 174.9, 176.0, 170.1, 170.1, 172.0, 175.2, 169.4, 177.7, 177.2, 174.0, 174.2, 171.6, 176.0, 176.1, 172.3, 169.8, 168.6, 167.7, 173.3, 170.7, 173.8, 174.0, 170.0, 173.6, 173.2, 174.4, 168.1, 174.8, 174.3, 166.8, 172.9, 171.3, 168.5, 168.8, 166.5, 165.2, 169.9, 167.2, 169.7, 168.1, 167.7, 169.4, 170.8, 162.5, 164.7, 163.1, 165.3, 163.1, 164.4, 162.2, 169.1, 163.3, 169.2]

    
    @Published var data: [model] = []
    @Published var smoothData: [model] = []
    
    var daysToSmooth: Int = 10 // well tested and can change arbitrarily
    
    // initailize smooth data as copy of data after it is built, then build it with a for loop:
    init() {
        // this declaration will not be neccisary later, and everything else will work fine when using a data, maybe be carefull to copy dae rather than use index
        data = weights.enumerated().map { index, weight in
            model(date: index + 1, weight: weight)
        }
        var incomplete:Float = 0
        for i in 0..<min(daysToSmooth-1, data.count){
            incomplete += data[i].weight
            let intermediate = model(date:data[i].date, weight: incomplete/Float(i+1))
            smoothData.append(intermediate)
        }
        if data.count > daysToSmooth-1 {
            var runSum: Float = 0
            for i in 0..<daysToSmooth{
                runSum += data[i].weight
            }
            let intermediate = model(date:data[daysToSmooth-1].date, weight: runSum/Float(daysToSmooth))
            smoothData.append(intermediate)
            for i in daysToSmooth..<data.count{
                runSum += data[i].weight
                runSum -= data[i-(daysToSmooth)].weight
                let intermediate = model(date:data[i].date, weight: runSum/Float(daysToSmooth))
                smoothData.append(intermediate)
            }
        }
        for i in 0..<smoothData.count {
            print(smoothData[i].date, smoothData[i].weight)
        }
    }
}

