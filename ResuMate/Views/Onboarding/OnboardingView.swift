//
//  OnboardingVIEW.swift
//  ResuCreate
//
//  Created by Muhammad Afif Maruf on 12/06/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var currentPage: Int = 0
    @State var isStartNow: Bool = false
    var body: some View {
        if isStartNow{
            HomeView(selection: 0)
        } else{
            switch currentPage{
            case 0:
                OnBoardingItem(img: "onboarding1",
                               img2: "empty-img",
                               customHeight: 302,
                              
                               currentPage: $currentPage, isStartNow: $isStartNow,
                               content: VStack{
                    HStack{
                       
                        Text("Create")
                            .blacktext28()
                            .bold()
                        Text("One resume")
                            .strongblue28()
                            .bold()
                        Text("for")
                            .blacktext28()
                            .bold()
                    
                    }
                    HStack{
                        Text("one job")
                            .strongblue28()
                            .bold()
                        Text("easily")
                            .blacktext28()
                            .bold()
                    }
                },
                button: BigButton(text: currentPage != 2 ? "Next" : "Start Now", isButtonactive: true) {
                    if currentPage == 2{
                        isStartNow = true
                    }
                    currentPage += 1
                }
                )
                               
            case 1:
                OnBoardingItem(img: "onboarding2",
                               img2: "suggestion",
                               customHeight: 200,
                               currentPage: $currentPage, isStartNow: $isStartNow,
                               content: VStack{
                    HStack{
                        Text("Suggestion,")
                            .strongblue28()
                            .bold()
                        Text("help write")
                            .blacktext28()
                            .bold()
                       
                    }
                    HStack{
                        Text("your story in")
                            .blacktext28()
                            .bold()
                        Text("second")
                            .strongblue28()
                            .bold()
                    }
                },
                button: Button {
                    if currentPage == 2{
                        isStartNow = true
                    }
                    currentPage += 1
                } label: {
                    Text("Next")
                        .white15()
                        .fontWeight(.medium)
                        .frame(width: 328, height: 50)
                        .cornerRadius(17)
                        .overlay(RoundedRectangle(cornerRadius: 17).stroke(.white, lineWidth: 2))
                })
            case 2:
                OnBoardingItem(img: "onboarding3",
                               img2: "generate-phrases",
                               customHeight: 187,
                               currentPage: $currentPage, isStartNow: $isStartNow,
                               content: VStack{
                    HStack{
                        Text("Generate phrase based on your").blacktext22()
                            .bold()
                        
                    }
                    HStack{
                        Text("experience with").blacktext22()
                            .bold()
                        Text("STAR (Situation,")
                            .strongblue22()
                            .bold()
                    }
                    HStack{
                        Text("Task, Action, Result)")
                            .strongblue22()
                            .bold()
                        Text("method.")
                            .blacktext22()
                            .bold()
                    }
                },
                button: BigButton(text: currentPage != 2 ? "Next" : "Start Now", isButtonactive: true) {
                    if currentPage == 2{
                        isStartNow = true
                    }
                    currentPage += 1
                })
            default:
                Text("")
            }
        
            
        }
        
        
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct OnBoardingItem: View{
    @State var img: String
    @State var img2: String
    @State var customHeight: CGFloat
    
    @Binding var currentPage:Int
    @Binding var isStartNow:Bool
    @State var content: any View
    @State var button: any View
    var body: some View{
        
        ZStack{
            VStack{
                Image(img)
                    .resizable()
                    .frame(height: 900)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack{
                Spacer()
                VStack{
                    Image(img2)
                        .resizable()
                        .scaledToFit()
                        .frame(height: customHeight)
                    AnyView(content)
                }
                
                Spacer().frame(height: 135)
                HStack{
                    ForEach(0..<3){ itm in
                        Circle()
                            .scaledToFit()
                            .frame(width: 10)
                            .foregroundColor( itm == currentPage ? Color.mediumBlue : .gray)
                    }
                }
                Spacer().frame(height: 105)
                AnyView(button)
                Spacer().frame(height: 100)
            }
        }
    }
}

