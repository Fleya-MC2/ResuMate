//
//  TQuestion.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct TQuestionView: View {
    @State var tqAnswer: String = ""
    @Binding var step: Int
    @Binding var progress: CGFloat
    @Binding var currentPage: GeneratePhrasesPage
    @EnvironmentObject var gpAnswer: GeneratePhrasesAnswer
    @State var isButtonActive: Bool = true

    var body: some View {
            VStack{
                GeneratePhrasesToolbar(titleToolbar: "Auto Generate Phrases") {
                    progress = progress - 0.20
                    step = 2
                    currentPage = .sQuestion
                }
                InfoCard(info: "TQuestion")
                ProgressBar(progress: progress, step: step)
                GeneratePhrasesForm(question: "TQuestion", fill: $tqAnswer)
                Spacer()
 
                    BigButton(text: "Next", isButtonactive: true) {
                        gpAnswer.tquestion = tqAnswer
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
