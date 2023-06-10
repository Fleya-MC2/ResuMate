//
//  ModalPersonalData.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct SuggestionSheet: View {
    @EnvironmentObject var cardLists: CardLists
    @Binding var isSuggestion: Bool
    @Binding var isGenerate: Bool

    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Personal Data")
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
                        RecomendationBox(recomendText: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid")
                    }
                    
                    
                }
                Spacer()
                Button{
                    isGenerate.toggle()
                    isSuggestion.toggle()
                    cardLists.currentPageView = "personalData"
                    
                }label: {
                    BigButton(text: "Need something more?", isButtonactive: true)
                }
                
                
                
            }.padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: 500)
                .background(Color.modal)
        }
    }
}

struct SuggestionSheetData_Previews: PreviewProvider {
    var isSuggestion: Bool = false
    static var previews: some View {
        
        SuggestionSheet(isSuggestion: .constant(false), isGenerate: .constant(false))
    }
}

struct RecomendationBox: View{
    @State var recomendText: String
    var body: some View{
        Text(recomendText)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .frame(width: 340)
            .background(.white)
            .cornerRadius(9)
    }
}
