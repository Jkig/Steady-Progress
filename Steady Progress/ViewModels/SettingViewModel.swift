//
//  SettingViewModel.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/21/23.
//

import Foundation


class SettingsViewModel:ObservableObject {
    @Published var direction = ["Loose weight", "Maintain weight", "Gain weight"]
    @Published var isKilograms = false
    @Published var showGoal = true
    @Published var showGoalLine = true
    @Published var showSmooth = true
    @Published var selection = "Loose weight"
}
