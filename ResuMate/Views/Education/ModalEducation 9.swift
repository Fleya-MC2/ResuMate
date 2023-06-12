//
//  ModalEducation.swift
//  ResuMate
//
//  Created by Luthfi Asmara on 10/06/23.
//

import SwiftUI

struct ModalEducation: View {
    @EnvironmentObject var cardLists: CardLists
    @Binding var isSuggestion: Bool
    @Binding var isGenerate: Bool
    @State var isButtonActive: Bool = false

    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Education Background")
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
                                .fill(Color.darkGray)
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                        
                            )
                    }
                    
                    
                    
                }.frame(height: 75)
                Divider()
                Spacer().frame(height: 30)
                ScrollView{
                    ForEach(0..<3){_ in
                        ItemCard(text: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid", isShowingThumbsUp: false, isShowingDraggable: false, isShowingClose: false) {}
                    }
                    
                    
                }
                Spacer()

                    BigButton(text: "Need something more?", isButtonactive: isButtonActive) {
                        isGenerate.toggle()
                        isSuggestion.toggle()
                        cardLists.currentPageView = "education"
                    }
                
                
                
            }.padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: 500)
                .background(Color.modal)
        }
    }
}

