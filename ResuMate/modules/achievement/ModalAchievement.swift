//
//  ModalAchievement.swift
//  ResuMate
//
//  Created by Luthfi Asmara on 10/06/23.
//

import SwiftUI

struct ModalAchievement: View {
    @EnvironmentObject var cardLists: CardLists
    @Binding var isSuggestion: Bool
    @Binding var isGenerate: Bool
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Achievement")
                        .blacktext15()
                        .fontWeight(.semibold)
                    Spacer()
                    Button{
                        isSuggestion.toggle()
                    }label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .background(Circle()
                                .fill(Color.grayop)
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                        
                            )
                    }
                    
                    
                    
                }.frame(height: 75)
                Divider()
                Spacer().frame(height: 30)
                ScrollView{
                    RecomendationBox(recomendText: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid")
                    RecomendationBox(recomendText: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabiahbhdbhwbhvdvewhvudveuwhvfuvdudvwfhvduvufvdsvfudvjfbjiwbfiubwuebfuewbd")
                    
                }
                Spacer()
                Button{
                    isGenerate.toggle()
                    isSuggestion.toggle()
                    cardLists.currentPageView = "achievement"
                }label: {
                    BigButton(text: "Need something more?", isButtonactive: true)
                }
                
                
                
            }.padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: 500)
                .background(Color.modal)
        }
    }
}

