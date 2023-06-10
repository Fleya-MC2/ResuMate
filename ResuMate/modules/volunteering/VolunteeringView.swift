//
//  Volunteering.swift
//  ResuMate
//
//  Created by Luthfi Asmara on 10/06/23.
//

import SwiftUI

struct Volunteering: View {
    @EnvironmentObject var cardLists: CardLists
    @State var isButtonActive: Bool = true
    @State var isSubmit: Bool = false
    var body: some View {
        if isSubmit{
            DataView()
        }else{
            NavigationStack{
                VStack{
                    CustomToolbar(titleToolbar: "Volunteering Experience", destinationL: HomePage(selection: 1), destinationT: AddVolunteering())
                    Spacer().frame(height: 17)
                    Text("Borem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.")
                        .blacktext17()
                        .fontWeight(.light)
                        .padding(.horizontal, 20)
                    Spacer().frame(height: 40)
                    ForEach(cardLists.volunteer){ itm in
                        HStack{
                            Text("\(itm.position) - \(itm.volunteer)")
                                .blacktext15()
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                            
                        }.padding(.horizontal, 20)
                        .frame(width: 338, height: 55)
                            .cornerRadius(9)
                            .overlay(RoundedRectangle(cornerRadius: 9).stroke(.gray, lineWidth: 1))
                        
                    }
                    if cardLists.volunteer.count == 0 {
                        NavigationLink{
                            AddVolunteering()
                        }label:{
                            HStack{
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.strongblue)
                                Text("Add Volunteering")
                                    .strongblue15()
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    Spacer()
                    Button{
                        cardLists.isVolunteringFilled = false
                        isSubmit = true
                    }label: {
                        BigButton(text: "Submit", isButtonactive: isButtonActive)
                    }
                    
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
                
            }.navigationBarBackButtonHidden(true)
            
        }
    }
}
