//
//  ModalPersonalData.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct SelectItemSheet: View {
    @EnvironmentObject var cardLists: CardLists
    
    var text: String
    
    var isGeneratePhraseButtonEnabled: Bool
    let onGeneratePhraseButtonClicked: () -> Void
    
    let onClosedClicked: () -> Void
    let onItemClicked: () -> Void
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text(text)
                        .blacktext15()
                        .fontWeight(.semibold)
                    
                    Spacer()
                    Button{
                        onClosedClicked()
                    }label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .background(Circle()
                                .fill(Color.mediumGray)
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            )
                    }
                }.frame(height: 75)
                    .padding(.horizontal, 20)
                Divider()
                Spacer().frame(height: 30)
                ScrollView{
                    ForEach(0..<3){_ in
                        Button {
                            onItemClicked()
                            onClosedClicked()
                        } label: {
                            ItemCard(text: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid", isShowingThumbsUp: true, isShowingDraggable: false, isShowingClose: false) {}
                                .padding(.horizontal)
                        }

                        
                    }
                }
                Spacer()
                
                if isGeneratePhraseButtonEnabled {
                    BigButton(text: "Need something more?", isButtonactive: true) {
                        onGeneratePhraseButtonClicked()
                        onClosedClicked()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 500)
            .background(Color.lightGray)
        }
    }
}

struct SuggestionSheetData_Previews: PreviewProvider {
    var isSuggestion: Bool = false
    static var previews: some View {
        
        SelectItemSheet(
            text: "Personal Data",
            isGeneratePhraseButtonEnabled: true,
            onGeneratePhraseButtonClicked: {},
            onClosedClicked: {},
            onItemClicked: {}
        )
    }
}
