//
//  Achievement.swift
//  ResuMate
//
//  Created by Luthfi Asmara on 10/06/23.
//

import SwiftUI

struct AchievementView: View {
    @EnvironmentObject var cardLists: CardLists
    @State var isButtonActive: Bool = false
    @State var isSubmit: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        if isSubmit{
            DataView()
        }else{
            NavigationStack{
                VStack{
                    CustomToolbar(titleToolbar: "Achievement", destinationL: HomeView(selection: 1), destinationT: AddAchievement())
                    Spacer().frame(height: 17)
                    Text("Borem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.")
                        .blacktext17()
                        .fontWeight(.light)
                        .padding(.horizontal, 20)
                    Spacer().frame(height: 40)
                    ForEach(cardLists.achievement){ itm in
                        HStack{
                            Text("\(itm.achieve) - \(itm.year)")
                                .blacktext15()
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                            
                        }.padding(.horizontal, 20)
                        .frame(width: 338, height: 55)
                            .cornerRadius(9)
                            .overlay(RoundedRectangle(cornerRadius: 9).stroke(.gray, lineWidth: 1))
                        
                    }
                    if cardLists.achievement.count == 0 {
                        NavigationLink{
                            AddAchievement()
                        }label:{
                            HStack{
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.darkBlue)
                                Text("Add Achievement")
                                    .strongblue15()
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    Spacer()

                        BigButton(text: "Submit", isButtonactive: isButtonActive) {
                            if isButtonActive{
                                cardLists.isAchievementFilled = true
                                isSubmit = true
                            }
                        }
                    
                    
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onReceive(timer) { time in
                        
                        if cardLists.achievement.count != 0 {
                            isButtonActive = true
                        }
                        print(isButtonActive)
                    }
                
                
                
            }.navigationBarBackButtonHidden(true)
            
        }
    }
}
