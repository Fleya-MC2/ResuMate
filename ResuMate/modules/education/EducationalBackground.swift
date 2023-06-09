//
//  EducationalBackground.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct EducationalBackground: View {
//    @Binding var navigationItemPath: [NavigationItem]

    @State var isButtonActive: Bool = true
    @State var lengthEduData = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        
        NavigationStack{
            VStack{
                CustomToolbar(titleToolbar: "Educational Background", destinationL: HomePage(selection: 1), destinationT: AddEducation())
                Spacer().frame(height: 17)
                Text("Borem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.")
                    .blacktext17()
                    .fontWeight(.light)
                    .padding(.horizontal, 20)
                Spacer().frame(height: 40)
                NavigationLink{
                    AddEducation()
                }label:{
                    HStack{
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.strongblue)
                        Text("Add Education")
                            .strongblue15()
                            .fontWeight(.semibold)
                    }
                }
                Spacer()
                BigButton(text: "Submit", isButtonactive: isButtonActive)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            

            
            
        }.navigationBarBackButtonHidden(true)
            
            
    }
}

//struct EducationalBackground_Previews: PreviewProvider {
//    static var previews: some View {
//        EducationalBackground()
//    }
//}
