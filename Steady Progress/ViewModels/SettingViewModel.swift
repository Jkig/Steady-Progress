//
//  SettingViewModel.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/21/23.
//

import Foundation
import SwiftUI

class SettingsViewModel:ObservableObject {
    @AppStorage("showGoal") var storedShowGoal:Bool = true
    @AppStorage("showSmooth") var storedShowSmooth:Bool = true
    @AppStorage("selection") var storedSelection:String = "Lose weight"
    
    
    @Published var showGoal:Bool = true
    @Published var showSmooth:Bool = true
    @Published var selection:String = "Lose weight"
    
    /*
    // if i add bmi and other stuff this will be the start
    @Published var isKilograms = false
    @Published var showGoalLine = true
    @Published var showBMI = true
    @Published var heightFeet = 5
    @Published var heightInches = 9
     */
    
    
    init() {
        showGoal = UserDefaults.standard.bool(forKey: "showGoal")
        showSmooth = UserDefaults.standard.bool(forKey: "showSmooth")
        selection = UserDefaults.standard.string(forKey: "selection") ?? "Lose weight"
    }
    
    func storeSettings(){
        /// call this in settings whenever any of these are updated, can extend with more options
        UserDefaults.standard.set(showGoal, forKey: "showGoal")
        UserDefaults.standard.set(showSmooth, forKey: "showSmooth")
        UserDefaults.standard.set(selection, forKey: "selection")
    }
}
