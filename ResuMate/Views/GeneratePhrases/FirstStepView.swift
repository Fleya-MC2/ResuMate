//
//  FirstStepView.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 09/06/23.
//

import Foundation
import SwiftUI

class GeneratePhrasesAnswer: ObservableObject {
    @AppStorage("squestion") var squestion: String = ""
    @AppStorage("tquestion") var tquestion: String = ""
    @AppStorage("aquestion") var aquestion: String = ""
    @AppStorage("rquestion") var rquestion: String = ""
    
}
struct GeneratePhrases: View {
    var inputType: InputType
    
    @State private var currentPage: GeneratePhrasesPage = .generatePhrases
    @State var progress: CGFloat = 0.2
    @State var step: Int = 1
    
    var body: some View {
        VStack{
            switch currentPage {
            case .generatePhrases:
                FirstStepView(step: $step, progress: $progress, currentPage: $currentPage)
            case .sQuestion:
                SQuestionView(step: $step, progress: $progress, currentPage: $currentPage)
            case .tQuestion:
                TQuestionView(step: $step, progress: $progress, currentPage: $currentPage)
            case .aQuestion:
                AQuestionView(step: $step, progress: $progress, currentPage: $currentPage)
            case .rQuestion:
                RQuestionView(inputType: inputType, step: $step, progress: $progress, currentPage: $currentPage)
            }
        }
    }
}

struct FirstStepView: View{
    @Binding var step: Int
    @Binding var progress: CGFloat
    @Binding var currentPage: GeneratePhrasesPage
    @State var isButtonActive: Bool = true

    

    var body: some View{
        
            VStack{
                
                CustomToolbar2(titleToolbar: "Auto Generate Phrases", destination: HomeView(selection:1))
                    
                StepBar(progress: progress, step: step)
                Image("GeneratePhrases")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 274)
                Spacer().frame(height: 44)
                Text("We Help You")
                    .font(.system(size: 22))
                    .bold()
                    .foregroundColor(.darkBlue)
                Spacer().frame(height: 10)
                Text("We can help you generate phrases that describe you more with STAR method. Answer the question and let us work.")
                    .multilineTextAlignment(.center)
                    .frame(width: 323)
                Spacer()

                    BigButton(text: "Next", isButtonactive: isButtonActive) {
                        if progress == 1{
                            progress = 1
                            step = 5
                        }
                        else{
                            progress = progress + 0.20
                            step = 2
                            currentPage = .sQuestion
                        }
                    }
                
                
                Spacer().frame(height: 50)
            }
        .navigationBarBackButtonHidden(true)
            

    }
}
