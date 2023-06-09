//
//  OnboardingButton.swift
//  JobMate
//
//  Created by Luthfi Asmara on 30/05/23.
//

import SwiftUI

struct OnboardingButton: View {
    @Binding var currentPage: Int
    var body: some View {
        Button{
            currentPage += 1
            if currentPage == 4{
                currentPage = 0
            }
            print(currentPage)
        }label: {
            Text(currentPage < 2 ? "Continue" : "Create a new Resume")
                .foregroundColor(.white)
                .frame(width: 340, height: 44)
                .background(.blue)
                .cornerRadius(6)
        }
    }
}


struct Previews_OnboardingButton_Previews: PreviewProvider {
    static var previews: some View {
       Text("hallo")
    }
}
