//
//  EnvironmentViewModel.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/24/23.
//

import Foundation

class EnvironmentViewModel: ObservableObject {
    @Published var keyboardIsPresented:Bool = false
    @Published var reset:UUID = UUID()
    
}
