//
//  WorkExperience.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct WorkExperienceView: View {
    @EnvironmentObject var cardLists: CardLists
    @State var isButtonactive: Bool = false
    @State var isSubmit: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var isSubmitClicked: Bool = false

    
    var body: some View {
        if isSubmit {
            DataView()
        } else {
            NavigationStack{
                VStack{
                    CustomToolbar(titleToolbar: "Work Experience", destinationL: HomeView(selection: 1), destinationT: AddWorkExperienceView())
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
                            AddWorkExperienceView()
                        }label: {
                            HStack{
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.darkBlue)
                                Text("Add Work Experience")
                                    .strongblue15()
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    
                    Spacer()
                    
                        BigButton(text: "Submit", isButtonactive: isButtonactive) {
                            if isButtonactive{
                                cardLists.isWorkExpFilled = true
                                isSubmit = true
                            }
                        }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .onReceive(timer) { time in
                    
                    if cardLists.workExp.count != 0 {
                        isButtonactive = true
                    }
                    print(isButtonactive)
                }
                Spacer()
                    
                    BigButton(text: "Submit", isButtonactive: true) {
                        isSubmitClicked = true
                    
                }.onAppear{
                    cardLists.isWorkExpFilled = true
                }
            }
            .navigationDestination(isPresented: $isSubmitClicked, destination: {
                DataView()
            })
            .navigationBarBackButtonHidden(true)
        }

    }
    
}

//struct WorkExperience_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkExperience()
//    }
//}
