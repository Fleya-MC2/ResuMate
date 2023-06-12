//
//  TQuestion.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct TQuestionView: View {
    @Binding var step: Int
    @Binding var progress: CGFloat
    @Binding var currentPage: GeneratePhrasesPage
    @Binding var tAnswer: String
    @EnvironmentObject var gpAnswer: GeneratePhrasesAnswer
    @State var isButtonActive: Bool = true
    
    var body: some View {
        VStack{
            GeneratePhrasesToolbar(titleToolbar: "Auto Generate Phrases") {
                progress = progress - 0.20
                step = 2
                currentPage = .sQuestion
            }

            InfoCard(info: "Explain the specific task or objective you needed to accomplish in that situation. Clearly define what you were responsible for.")
            
            StepBar(progress: progress, step: step)
            
            AreaForm(title: "Whats your responsibilty in that challenge?", fill: $tAnswer, isCheck: .constant(false), isSuggestionEnabled: false) {}
            
            Spacer()
            
            BigButton(text: "Next", isButtonactive: true) {
                gpAnswer.tquestion = tAnswer
                if progress == 1{
                    progress = 1
                    
                }
                else{
                    progress = progress + 0.20
                    currentPage = .aQuestion
                    step = 4
                }
            }
            Spacer().frame(height: 50)
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct TQuestion_Previews: PreviewProvider {
//    static var previews: some View {
//        TQuestion(progress: 0)
//    }
//}
