//
//  WorkExperience.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct WorkExperienceView: View {
    @EnvironmentObject var cardLists: CardLists
    
    @State var isSubmitClicked: Bool = false

    var body: some View {
        NavigationStack{
            VStack{
                CustomToolbar(titleToolbar: "Work Experience", destinationL: HomeView(selection: 1), destinationT: AddWorkExperienceView())
                HStack{
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.darkBlue)
                    Text("Add Work Experience")
                        .strongblue15()
                        .fontWeight(.semibold)
                }
                Spacer()
                    
                    BigButton(text: "Submit", isButtonactive: true) {
                        isSubmitClicked = true
                    
                }.onAppear{
                    cardLists.isWorkExpFilled = true
                }
            }
        }
        .navigationDestination(isPresented: $isSubmitClicked, destination: {
            DataView()
        })
        .navigationBarBackButtonHidden(true)
    }
    
}

//struct WorkExperience_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkExperience()
//    }
//}
