//
//  MainViewModel.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/21/23.
//

import Foundation
import SwiftUI


struct Model: Codable, Identifiable {
    var id: Int // I think change this to simly the index it is at, should be fine onece dates are accrate
    var date: Date
    var weight: Double
    
    init(id:Int ,date:Date, weight:Double) {
        self.id = id
        self.date = date
        self.weight = weight
    }
}


class MainViewModel: ObservableObject {
    @StateObject var environmentView = EnvironmentViewModel()
    // @Published var keyboardIsPresented: Bool = false
    @Published var showAlert:Bool = false
    @Published var daysToSmooth:Int = 14
    
    // the app storeage and publish stuff here is having wierd defaults
    @AppStorage("goal") var storedGoal:Double = 160
    @AppStorage("minVal") var storedMinVal:Double = 400
    @AppStorage("maxVal") var storedMaxVal:Double = 500.0097
    @AppStorage("startWeight") var storedStartWeight:Double = 160
    
    
    @Published var goal:Double = 160
    @Published var minVal:Double = 400
    @Published var maxVal:Double = 500
    @Published var startWeight:Double = 160
    @Published var data: [Model] = []
    @Published var smoothData: [Model] = []
    
    
    init() {
        goal = UserDefaults.standard.double(forKey: "goal")
        minVal = UserDefaults.standard.double(forKey: "minVal")
        maxVal = UserDefaults.standard.double(forKey: "maxVal")
        startWeight = UserDefaults.standard.double(forKey: "startWeight")
        // resetStored()
        
        if let data = UserDefaults.standard.data(forKey: "dataKey") {
            let decoder = JSONDecoder()
            if let decodedModels = try? decoder.decode([Model].self, from: data) {
                self.data = decodedModels
            }
        }
        
        if let smoothData = UserDefaults.standard.data(forKey: "smoothDataKey") {
            let decoder = JSONDecoder()
            if let decodedSmoothModels = try? decoder.decode([Model].self, from: smoothData) {
                self.smoothData = decodedSmoothModels
            }
        }
    }
    
    func storeData() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(data) {
            UserDefaults.standard.set(encodedData, forKey: "dataKey")
        }
        
        if let encodedSmoothData = try? encoder.encode(smoothData) {
            UserDefaults.standard.set(encodedSmoothData, forKey: "smoothDataKey")
        }
        
    }
    
    func resetStored() {
        UserDefaults.standard.set(170, forKey: "minVal")
        UserDefaults.standard.set(185, forKey: "maxVal")
        UserDefaults.standard.set(startWeight, forKey: "startweight")
        
        
        goal = UserDefaults.standard.double(forKey: "goal")
        minVal = UserDefaults.standard.double(forKey: "minVal")
        maxVal = UserDefaults.standard.double(forKey: "maxVal")
        startWeight = UserDefaults.standard.double(forKey: "startWeight")
        
        
        UserDefaults.standard.set(nil, forKey: "dataKey")
        UserDefaults.standard.set(nil, forKey: "smoothDataKey")
        
    }
    
    
    func setupDemo(weights:[Double], start:Double){
        resetStored()
        data = []
        smoothData = []
        resetStored()
        
        startWeight = start
        UserDefaults.standard.set(startWeight, forKey: "startweight")
        
        startTestData(weights:weights)
    }
    
    func startTestData(weights:[Double]) {
        data = weights.enumerated().map { index, weight in
            Model(id: index, date: Date().addingTimeInterval(Double(index)*(24*60 * 60)) - (100*24*60*60), weight: weight)
        }
        /*
         // quick test for how holes in data are treadted (perfectly!) :)
         var intermediateData:[Model] = []
         intermediateData.append(contentsOf: data[0..<30])
         intermediateData.append(contentsOf: data[50..<data.count])
         
         for i in 0..<intermediateData.count{
             intermediateData[i].id = i
         }
         
         data = intermediate
         */
        setUpData()
    }
    
    func setUpData(){
        var minValSoFar:Double = 1000
        var maxValSoFar:Double = 0
        
        
        var incomplete:Double = 0
        
        for i in 0..<min(daysToSmooth-1, data.count){
            incomplete += data[i].weight
            smoothData.append(Model(id: i, date:data[i].date, weight: incomplete/Double(i+1)))
            
            if data[i].weight > maxValSoFar {
                    maxValSoFar = data[i].weight
            }
            if data[i].weight < minValSoFar {
                    minValSoFar = data[i].weight
            }
        }
        if data.count > daysToSmooth-1 {
            startWeight = data[daysToSmooth-1].weight
            
            var runSum: Double = 0
            for i in 0..<daysToSmooth{
                runSum += data[i].weight
            }
            if data[daysToSmooth-1].weight > maxValSoFar {
                    maxValSoFar = data[daysToSmooth-1].weight
            }
            if data[daysToSmooth-1].weight < minValSoFar {
                    minValSoFar = data[daysToSmooth-1].weight
            }
            smoothData.append(Model(id: daysToSmooth-1, date:data[daysToSmooth-1].date, weight: runSum/Double(daysToSmooth)))
            for i in daysToSmooth..<data.count{
                runSum += data[i].weight
                runSum -= data[i-(daysToSmooth)].weight
                smoothData.append(Model(id: i, date:data[i].date, weight: runSum/Double(daysToSmooth)))
                
                if data[i].weight > maxValSoFar {
                        maxValSoFar = data[i].weight
                }
                if data[i].weight < minValSoFar {
                        minValSoFar = data[i].weight
                }
            }
        }
        minVal = min(goal*0.95, minValSoFar*0.95)
        maxVal = max(goal*1.05+1, (maxValSoFar*1.05)+1)
        
        /*
        for i in 0..<data.count{
            print(i)
            print(data[i].id, data[i].date, data[i].weight)
            print(smoothData[i].id, smoothData[i].date, smoothData[i].weight)
        }
         */
        
        
        UserDefaults.standard.set(minVal, forKey: "minVal")
        UserDefaults.standard.set(maxVal, forKey: "maxVal")
        UserDefaults.standard.set(startWeight, forKey: "startweight")
        storeData()
    }
    
    
    func deleteOld(index:Int) {
        // for now, I'll probably just recalculate the smoothed, but later I should save the time
        // if deleting the largest or smallest just recalculate?
        var intermediateData: [Model] = []
        
        if index == 0{
            intermediateData.append(contentsOf: data[1..<data.count])
            
        } else {
            intermediateData.append(contentsOf: data[0..<index])
            intermediateData.append(contentsOf: data[index+1..<data.count])
        }
        for i in 0..<intermediateData.count{
            intermediateData[i].id = i
        }
        
        data = intermediateData
        smoothData = []
        setUpData()
    }
    
    
    func addMeasurement(weightSTR:String) {
        if weightSTR == ""{
            return
        }
        /*
        if !data.isEmpty{
            if Date() < data.last!.date + (10*60*60) {
                showAlert = true
                return
            }
        }
        */
        let weight:Double = Double(weightSTR)!
        minVal = min(weight*0.95, minVal)
        maxVal = max(weight*1.05+1, maxVal)
        
        if minVal == 0 {
            minVal = min(weight*0.95, goal*0.95)
        }
        if maxVal == 500.0097{
            maxVal = max(weight*1.05+1, goal*1.05+1)
        }
        
        data.append(Model(id: data.count, date: Date(), weight: weight))
        var newSmoothWeight:Double = 0
        if data.count < daysToSmooth {
            var total:Double = 0
            
            for model in data{
                total += model.weight
            }
            newSmoothWeight = total/Double(data.count)
        }
        else{
            var total:Double = 0
            // 10 to smooth
            // now we have 10 things,, so can go from 0-9, and 1-11
            for model in data[data.count-daysToSmooth..<data.count]{
                total += model.weight
            }
            newSmoothWeight = total/Double(daysToSmooth)
        }
        smoothData.append(Model(id:data.last!.id, date:data.last!.date, weight: newSmoothWeight))
        
        // first time, need to establish startWeight
        if startWeight == 0 {
            startWeight = newSmoothWeight
        }
        
        UserDefaults.standard.set(minVal, forKey: "minVal")
        UserDefaults.standard.set(maxVal, forKey: "maxVal")
        UserDefaults.standard.set(startWeight, forKey: "startweight")
        storeData()
    }
    
    func setGoal(newGoal: Double){
        goal = newGoal
        UserDefaults.standard.set(goal, forKey: "goal")
        
        
        if !data.isEmpty {
            var minOfVals:Double = 2000
            var maxOfVals:Double = 0
            
            for i in 0..<data.count {
                if data[i].weight < minOfVals{
                    minOfVals = data[i].weight
                }
                if data[i].weight > maxOfVals{
                    maxOfVals = data[i].weight
                }
            }
            
            minVal = min(goal*0.95, minOfVals*0.95)
            maxVal = max(goal*1.05+1, maxOfVals*1.05+1)
            
            UserDefaults.standard.set(minVal, forKey: "minVal")
            UserDefaults.standard.set(maxVal, forKey: "maxVal")
        } else {
            minVal = min(minVal, goal*0.95)
            maxVal = max(maxVal, goal*1.05+1)
            
            
            UserDefaults.standard.set(minVal, forKey: "minVal")
            UserDefaults.standard.set(maxVal, forKey: "maxVal")
        }
    }
}

