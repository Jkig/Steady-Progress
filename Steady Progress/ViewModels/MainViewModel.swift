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
    
    
    @AppStorage("goal") var storedGoal:Double = 160
    @AppStorage("minVal") var storedMinVal:Double = 500
    @AppStorage("maxVal") var storedMaxVal:Double = 500
    @AppStorage("startWeight") var storedStartWeight:Double = 0
    
    
    @Published var goal:Double
    @Published var minVal:Double = 500
    @Published var maxVal:Double = 0
    @Published var startWeight:Double = 0
    @Published var data: [Model] = []
    @Published var smoothData: [Model] = []
    
    
    init() {
        goal = UserDefaults.standard.double(forKey: "goal")
        minVal = UserDefaults.standard.double(forKey: "minVal")
        maxVal = UserDefaults.standard.double(forKey: "maxVal")
        startWeight = UserDefaults.standard.double(forKey: "startWeight")
        // resetStored()
        
        print("in innit")
        if let data = UserDefaults.standard.data(forKey: "dataKey") {
            print("trying to read raw")
            let decoder = JSONDecoder()
            if let decodedModels = try? decoder.decode([Model].self, from: data) {
                print("reading raw")
                self.data = decodedModels
            }
        }
        
        if let smoothData = UserDefaults.standard.data(forKey: "smoothDataKey") {
            print("trying to read smooth")
            let decoder = JSONDecoder()
            if let decodedSmoothModels = try? decoder.decode([Model].self, from: smoothData) {
                print("reading smooth")
                self.smoothData = decodedSmoothModels
            }
        }
        
        // setupTesting()
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
    
    
    func setupTesting( ){
        resetStored()
        startTestData()
    }
    
    func startTestData() {
        let weights: [Double] = [186.2, 185.8, 186.4, 186.2, 184.8, 186.2, 186.7, 186.6, 185.1, 184.3, 184.9, 183.3, 185.9, 184.7, 182.5, 184.6, 183.2, 182.7, 182.8, 183.5, 185.7, 182.8, 182.5, 183.0, 184.3, 185.4, 180.2, 179.2, 183.9, 184.6, 179.4, 180.8, 182.6, 178.6, 181.3, 179.2, 183.9, 179.8, 182.9, 180.5, 183.2, 179.8, 180.5, 182.7, 179.9, 179.9, 180.7, 179.5, 180.0, 180.1, 180.3, 181.5, 180.3, 178.9, 177.5, 181.8, 181.0, 176.7, 176.1, 178.7, 181.8, 179.6, 178.1, 181.5, 177.6, 180.3, 177.7, 175.5, 179.8, 178.4, 180.7, 179.7, 179.9, 180.5, 180.1, 175.7, 178.6, 175.6, 178.2, 176.0, 177.8, 175.5, 176.7, 173.8, 178.0, 176.7, 176.2, 174.6, 176.9, 176.6, 173.4, 173.0, 175.0, 176.3, 176.8, 173.8, 178.0, 174.8, 172.5, 172.7]
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
            
        } else if index == data.count{
            intermediateData.append(contentsOf: data[0..<data.count-1])
            
        } else{
            intermediateData.append(contentsOf: data[0..<index-1])
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
            // environmentView.keyboardIsPresented = false
            return
        }
        
        if !data.isEmpty{
            if Date() < data.last!.date + (10*60*60) {
                showAlert = true
                // environmentView.keyboardIsPresented = false
                return
            }
        }
        
        let weight:Double = Double(weightSTR)!
        minVal = min(weight*0.95, minVal)
        maxVal = max(weight*1.05+1, maxVal)
        
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
        setUpData()
        
        UserDefaults.standard.set(goal, forKey: "goal")
        UserDefaults.standard.set(minVal, forKey: "minVal")
        UserDefaults.standard.set(maxVal, forKey: "maxVal")
    }
}

