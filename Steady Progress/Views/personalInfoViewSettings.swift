//
//  personalInfoViewSettings.swift
//  Steady Progress
//
//  Created by Derek Leroux on 7/10/23.
//

import SwiftUI

struct personalInfoViewSettings: View {
    var viewModel: SettingsViewModel
    var mainViewModel: MainViewModel
    
    var body: some View {
        // personal info section
        VStack{
            Button(action:{}, label:{
                NavigationLink("Set Personal Data", destination: PersonalInfoView())
            })
            .padding(8)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            HStack{
                
                Text("Age: 50")
                
                Text("Height: 50")
                /*
                if !mainViewModel.data.isEmpty{
                    Text("BMI: \(String(format: "%.1f", mainViewModel.data.last!.weight/pow(Double(viewModel.heightFeet * 12 + viewModel.heightInches),2)*703))")
                }
                 */
            }
            // Could say what the BMI means, but probably not really helpful, may pull it all as well as the personal data  entirely
            // Text("Passive caloric Burn: 2000")
        }
         
    }
}

struct personalInfoViewSettings_Previews: PreviewProvider {
    static var previews: some View {
        personalInfoViewSettings(viewModel: SettingsViewModel(), mainViewModel: MainViewModel())
    }
}
