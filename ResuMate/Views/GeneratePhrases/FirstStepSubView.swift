//
//  FirstStepView.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 09/06/23.
//

import Foundation
import SwiftUI

struct FirstStepSubView: View{
    @Binding var step: Int
    @Binding var progress: CGFloat
    @Binding var currentPage: GeneratePhrasesPage
    var body: some View{
        
            VStack{
                
                CustomToolbar2(titleToolbar: "Auto Generate Phrases", destination: HomeView(selection:1))
                    
                ProgressBar(progress: progress, step: step)
                Image("generate-phrases")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 274)
                Spacer().frame(height: 44)
                Text("We Help You")
                    .font(.system(size: 22))
                    .bold()
                    .foregroundColor(.darkblue)
                Spacer().frame(height: 10)
                Text("We can help you generate phrases that describe you more with STAR method. Answer the question and let us work.")
                    .multilineTextAlignment(.center)
                    .frame(width: 323)
                Spacer()
                Button{
                    
                        if progress == 1{
                            progress = 1
                            step = 5
                        }
                        else{
                            progress = progress + 0.20
                            step = 2
                            currentPage = .sQuestion
                        }
                    
                    
                }label: {
                    BigButton(text: "Next", isButtonactive: true)
                }
                
                Spacer().frame(height: 50)
            }
        .navigationBarBackButtonHidden(true)
            

    }
}
