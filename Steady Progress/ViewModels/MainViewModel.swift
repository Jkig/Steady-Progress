//
//  MainViewModel.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/21/23.
//

import Foundation


struct Model: Identifiable {
    var id: Int // I think change this to simly the index it is at, should be fine onece dates are accrate
    var date: Date
    var weight: Float
    
    init(id:Int ,date:Date, weight:Float) {
        self.id = id
        self.date = date
        self.weight = weight
    }
}


class MainViewModel: ObservableObject {
    // try importing settings here, get goal..
    @Published var keyboardIsPresented: Bool = false
    @Published var minVal:Float = 500
    @Published var maxVal:Float = 0
    @Published var goal:Float = 160
    @Published var daysToSmooth:Int = 10 // well tested and can change arbitrarily
    @Published var startWeight:Float = 0
    @Published var showAlert:Bool = false
    
    @Published var data: [Model] = []
    @Published var smoothData: [Model] = []
    
    // initailize smooth data as copy of data after it is built, then build it with a for loop:
    init() {
        /**/
        // setting up testing data:
        // commenting all this out and it works as normal
        let weights: [Float] = [186.2, 185.8, 186.4, 186.2, 184.8, 186.2, 186.7, 186.6, 185.1, 184.3, 184.9, 183.3, 185.9, 184.7, 182.5, 184.6, 183.2, 182.7, 182.8, 183.5, 185.7, 182.8, 182.5, 183.0, 184.3, 185.4, 180.2, 179.2, 183.9, 184.6, 179.4, 180.8, 182.6, 178.6, 181.3, 179.2, 183.9, 179.8, 182.9, 180.5, 183.2, 179.8, 180.5, 182.7, 179.9, 179.9, 180.7, 179.5, 180.0, 180.1, 180.3, 181.5, 180.3, 178.9, 177.5, 181.8, 181.0, 176.7, 176.1, 178.7, 181.8, 179.6, 178.1, 181.5, 177.6, 180.3, 177.7, 175.5, 179.8, 178.4, 180.7, 179.7, 179.9, 180.5, 180.1, 175.7, 178.6, 175.6, 178.2, 176.0, 177.8, 175.5, 176.7, 173.8, 178.0, 176.7, 176.2, 174.6, 176.9, 176.6, 173.4, 173.0, 175.0, 176.3, 176.8, 173.8, 178.0, 174.8, 172.5, 172.7]
        
        data = weights.enumerated().map { index, weight in
            Model(id: index, date: Date().addingTimeInterval(Double(index)*(24*60 * 60)) - (100*24*60*60), weight: weight)
        }
        // end testing data setup
        /**/
        
        var incomplete:Float = 0
        for i in 0..<min(daysToSmooth-1, data.count){
            incomplete += data[i].weight
            smoothData.append(Model(id: i, date:data[i].date, weight: incomplete/Float(i+1)))
            
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
            smoothData.append(Model(id: daysToSmooth-1, date:data[daysToSmooth-1].date, weight: runSum/Float(daysToSmooth)))
            for i in daysToSmooth..<data.count{
                runSum += data[i].weight
                runSum -= data[i-(daysToSmooth)].weight
                smoothData.append(Model(id: i, date:data[i].date, weight: runSum/Float(daysToSmooth)))
                
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
        
        
        // print through data
        /*
        for i in 0..<data.count{
            print(i)
            print(data[i].id, data[i].date, data[i].weight)
            print(smoothData[i].id, smoothData[i].date, smoothData[i].weight)
        }
         */
         
    }
    
    
    func deleteOld() {
        // TODO: we delete the old one, by copying the data up to a point, skipping, and etc, then being clever to copy only the right ones
        // for now, I'll probably just recalculate the smoothed, but later I should save the time
        // if deleting the largest or smallest just recalculate?
    }
    
    
    func addMeasurement(weightSTR:String) {
        if weightSTR == ""{
            keyboardIsPresented = false
            return
        }
        let weight:Float = Float(weightSTR)!
        
        if !data.isEmpty{
            if Date() < data.last!.date + (24*60*60) {
                showAlert = true
                keyboardIsPresented = false
                return
            }
        }
        
        minVal = min(weight*0.95, minVal)
        maxVal = max(weight*1.05+1, maxVal)
        
        data.append(Model(id: data.count, date: Date(), weight: weight))
        var newSmoothWeight:Float = 0
        if data.count < daysToSmooth {
            var total:Float = 0
            
            for model in data{
                total += model.weight
            }
            newSmoothWeight = total/Float(data.count)
        }
        else{
            var total:Float = 0
            // 10 to smooth
            // now we have 10 things,, so can go from 0-9, and 1-11
            for model in data[data.count-daysToSmooth..<data.count]{
                total += model.weight
            }
            newSmoothWeight = total/Float(daysToSmooth)
        }
        smoothData.append(Model(id:data.last!.id, date:data.last!.date, weight: newSmoothWeight))
        
        // first time, need to establish startWeight
        if startWeight == 0 {
            startWeight = newSmoothWeight
        }
        keyboardIsPresented = false
    }
    
    func setGoal(newGoal: Float){
        goal = newGoal
        minVal = min(goal*0.95, minVal)
        maxVal = max(goal*1.05+1, maxVal)
        
        keyboardIsPresented = false
    }
}

