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

    var body: some View {

                VStack{
                    CustomToolbar(titleToolbar: "Achievement", destinationL: HomeView(selection: 1), destinationT: AddAchievement(inputType: .add))
                    Spacer().frame(height: 17)
                    Text("Borem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.")
                        .blacktext17()
                        .fontWeight(.light)
                        .padding(.horizontal, 20)
                    Spacer().frame(height: 40)
                    ForEach(cardLists.achievement){ itm in
                        NavigationLink {
                            AddAchievement(inputType: .edit)
                        } label: {
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


                        
                    }
                    if cardLists.achievement.count == 0 {
                        NavigationLink{
                            AddAchievement(inputType: .add)
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
                .navigationDestination(isPresented: $isSubmit, destination: {
                    HomeView(selection: 1)
                })
                    .onReceive(cardLists.$achievement) { newAchievement in
                        if newAchievement.count != 0 {
                            isButtonActive = true
                        }
                        print(isButtonActive)
                    }
            .navigationBarBackButtonHidden(true)
    }
}
