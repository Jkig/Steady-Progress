//
//  SettingViewModel.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/21/23.
//

import Foundation
import SwiftUI

class SettingsViewModel:ObservableObject {
    @Published var direction = ["Lose weight", "Maintain weight", "Gain weight"]
    
    @AppStorage("showGoal") var storedShowGoal:Bool = true
    @AppStorage("showSmooth") var storedShowSmooth:Bool = true
    @AppStorage("selection") var storedSelection:String = "Lose weight"
    
    
    // @Published var isKilograms = false
    // @Published var showGoalLine = true
    @Published var showGoal:Bool = true
    @Published var showSmooth:Bool = true
    @Published var selection:String = "Lose weight"
    // @Published var showBMI = true
    // @Published var heightFeet = 5
    // @Published var heightInches = 9
    
    // whenever showGoal, showSmooth or selection are changed, make sure to update object
    // make a function that does that?
    
    init() {
        // TODO: init grab data from local storage if there is some
        showGoal = UserDefaults.standard.bool(forKey: "showGoal")
        showSmooth = UserDefaults.standard.bool(forKey: "showSmooth")
        selection = UserDefaults.standard.string(forKey: "selection") ?? "Lose weight"
    }
    
    func storeSettings(){
        UserDefaults.standard.set(showGoal, forKey: "showGoal")
        UserDefaults.standard.set(showSmooth, forKey: "showSmooth")
        UserDefaults.standard.set(selection, forKey: "selection")
    }
}
