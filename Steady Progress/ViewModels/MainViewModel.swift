//
//  MainViewModel.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/21/23.
//

import Foundation


class MainViewModel: ObservableObject {
    // try importing settings here, get goal..
    @Published var keyboardIsPresented: Bool = false
    @Published var minVal:Float = 500
    @Published var maxVal:Float = 0
    @Published var goal:Float = 160
    @Published var daysToSmooth: Int = 10 // well tested and can change arbitrarily
    @Published var startWeight:Float = 0
    
    // test data: setup here and on basically
    @Published var weights: [Float] = [188.4, 184.5, 184.6, 185.7, 180.0, 179.4, 185.0, 181.0, 186.0, 178.7, 179.6, 186.0, 179.9, 183.6, 186.4, 182.0, 180.3, 182.7, 181.2, 179.8, 181.6, 183.1, 176.4, 179.7, 181.6, 180.5, 176.2, 174.4, 175.1, 178.1, 174.6, 180.3, 182.0, 176.2, 176.9, 179.4, 174.7, 180.5, 181.7, 180.2, 176.2, 175.9, 174.3, 177.4, 174.3, 180.6, 175.0, 174.9, 176.0, 170.1, 170.1, 172.0, 175.2, 169.4, 177.7, 177.2, 174.0, 174.2, 171.6, 176.0, 176.1, 172.3, 169.8, 168.6, 167.7, 173.3, 170.7, 173.8, 174.0, 170.0, 173.6, 173.2, 174.4, 168.1, 174.8, 174.3, 166.8, 172.9, 171.3, 168.5, 168.8, 166.5, 165.2, 169.9, 167.2, 169.7, 168.1, 167.7, 169.4, 170.8, 162.5, 164.7, 163.1, 165.3, 163.1, 164.4, 162.2, 169.1, 163.3, 169.2]

    
    @Published var data: [Model] = []
    @Published var smoothData: [Model] = []
    
    // initailize smooth data as copy of data after it is built, then build it with a for loop:
    init() {
        // this declaration will not be neccisary later, and everything else will work fine when using a data, maybe be carefull to copy dae rather than use index
        data = weights.enumerated().map { index, weight in
            Model(date: index + 1, weight: weight)
        }
        var incomplete:Float = 0
        for i in 0..<min(daysToSmooth-1, data.count){
            incomplete += data[i].weight
            smoothData.append(Model(date:data[i].date, weight: incomplete/Float(i+1)))
            
            if data[i].weight > maxVal {
                    maxVal = data[i].weight
            }
            if data[i].weight < minVal {
                    minVal = data[i].weight
            }
        }
        if data.count > daysToSmooth-1 {
            startWeight = data[daysToSmooth-1].weight
            
            var runSum: Float = 0
            for i in 0..<daysToSmooth{
                runSum += data[i].weight
            }
            if data[daysToSmooth-1].weight > maxVal {
                    maxVal = data[daysToSmooth-1].weight
            }
            if data[daysToSmooth-1].weight < minVal {
                    minVal = data[daysToSmooth-1].weight
            }
            smoothData.append(Model(date:data[daysToSmooth-1].date, weight: runSum/Float(daysToSmooth)))
            for i in daysToSmooth..<data.count{
                runSum += data[i].weight
                runSum -= data[i-(daysToSmooth)].weight
                smoothData.append(Model(date:data[i].date, weight: runSum/Float(daysToSmooth)))
                
                if data[i].weight > maxVal {
                        maxVal = data[i].weight
                }
                if data[i].weight < minVal {
                        minVal = data[i].weight
                }
            }
        }
        // now alter min/max value
        minVal = min(goal*0.95, minVal*0.95)
        maxVal = max(goal*1.05+1, (maxVal*1.05)+1)
    }
    
    
    
    func deleteOld() {
        // TODO: we delete the old one, by copying the data up to a point, skipping, and etc, then being clever to copy only the right ones
        // for now, I'll probably just recalculate the smoothed, but later I should save the time
        // if deleting the largest or smallest just recalculate?
    }
    
    func addMeasurement() {
        // TODO: takes in a number/text, and appends one last measurement, then appends a smoothed measurement too
        // check if new measurement is largest or smallest, and updatae
    }
    
    func setGoal(newGoal: Float){
        goal = newGoal
        minVal = min(goal*0.95, minVal)
        maxVal = max(goal*1.05+1, maxVal)
    }
}

