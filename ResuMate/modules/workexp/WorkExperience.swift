//
//  WorkExperience.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct WorkExperience: View {
    @EnvironmentObject var cardLists: CardLists
    @State var isButtonactive: Bool = false
    @State var isSubmit: Bool = false
    
    var body: some View {
        if isSubmit {
            DataView()
        } else{
            NavigationStack{
                VStack{
                    CustomToolbar(titleToolbar: "Work Experience", destinationL: HomePage(selection: 1), destinationT: AddWorkExp())
                    Spacer().frame(height: 17)
                    Text("Borem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.")
                        .blacktext17()
                        .fontWeight(.regular)
                    Spacer().frame(height: 40)
                    ForEach(cardLists.workExp){ itm in
                        HStack{
                            Text("\(itm.position) - \(itm.company)")
                                .blacktext15()
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                            
                        }.padding(.horizontal, 20)
                        .frame(width: 338, height: 55)
                            .cornerRadius(9)
                            .overlay(RoundedRectangle(cornerRadius: 9).stroke(.gray, lineWidth: 1))
                        
                    }
                    if cardLists.workExp.count == 0 {
                        NavigationLink{
                            AddWorkExp()
                        }label: {
                            HStack{
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.strongblue)
                                Text("Add Work Experience")
                                    .strongblue15()
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    
                    Spacer()
                    Button{
                        cardLists.isWorkExpFilled = false
                        isSubmit = true
                    }label: {
                        BigButton(text: "Submit", isButtonactive: isButtonactive)
                    }
                }
                
                
                
            }.navigationBarBackButtonHidden(true)
        }
    }
    
}

//struct WorkExperience_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkExperience()
//    }
//}
