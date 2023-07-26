//
//  EnvironmentViewModel.swift
//  Steady Progress
//
//  Created by Derek Leroux on 6/24/23.
//

import Foundation

class EnvironmentViewModel: ObservableObject {
    @Published var keyboardIsPresented:Bool = false
    /// just makes sure keyboard doesn't stick around while nagigating or switching pages
    @Published var reset:UUID = UUID()
    /// only used for state that needs to be at a higher level, for example if a change in settings needs to update the main page or visa versa
    
}
