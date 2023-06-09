//
//  WorkExperience.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct WorkExperience: View {
//    @Binding var navigationItemPath: [NavigationItem]

    var body: some View {
        NavigationStack{
            VStack{
                CustomToolbar(titleToolbar: "Work Experience", destinationL: HomePage(selection: 1), destinationT: AddWorkExp())
                HStack{
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.strongblue)
                    Text("Add Work Experience")
                        .strongblue15()
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            
            
            
        }.navigationBarBackButtonHidden(true)
    }
}

//struct WorkExperience_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkExperience()
//    }
//}
