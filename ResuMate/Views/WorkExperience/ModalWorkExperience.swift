//
//  ModalWorkExperience.swift
//  ResuMate
//
//  Created by Luthfi Asmara on 10/06/23.
//

import SwiftUI

struct ModalWorkExperience: View {
    @EnvironmentObject var cardLists: CardLists
    @Binding var isSuggestion: Bool
    @Binding var isGenerate: Bool
    @State var isButtonActive: Bool = false

    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Work Experience")
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
                                .fill(Color.mediumDarkGray)
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                        
                            )
                    }
                    
                    
                    
                }.frame(height: 75)
                Divider()
                Spacer().frame(height: 30)
                ScrollView{
                    ItemCard(text: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid", isShowingThumbsUp: false)
                    ItemCard(text: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabiahbhdbhwbhvdvewhvudveuwhvfuvdudvwfhvduvufvdsvfudvjfbjiwbfiubwuebfuewbd", isShowingThumbsUp:  false)
                    
                }
                Spacer()

                    BigButton(text: "Need something more?", isButtonactive: true) {
                        isGenerate.toggle()
                        isSuggestion.toggle()
                        cardLists.currentPageView = "workExp"
                    }
                
                
                
                
            }.padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: 500)
                .background(Color.modal)
        }
    }
}
