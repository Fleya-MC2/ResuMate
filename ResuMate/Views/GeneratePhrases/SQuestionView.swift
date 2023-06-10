//
//  SQuestion.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct SQuestionView: View {
    @State var sqAnswer: String = ""
    @Binding var step: Int
    @Binding var progress: CGFloat
    @Binding var currentPage: GeneratePhrasesPage
    @EnvironmentObject var gpAnswer: GeneratePhrasesAnswer
    
    var body: some View {
        
            VStack{
                GeneratePhrasesToolbar(titleToolbar: "Auto Generate Phrases") {
                    progress = progress - 0.20
                    step = 1
                    currentPage = .generatePhrases
                }
                InfoCard(info: "Squestion")
                ProgressBar(progress: progress, step: step)
                
                GeneratePhrasesForm(question: "String", fill: $sqAnswer)
                   
                
                Spacer()
                Button{
                    gpAnswer.squestion = sqAnswer
                    if progress == 1{
                        progress = 1
                    }
                    else{
                        progress = progress + 0.20
                        step = 3
                        currentPage = .tQuestion
                    }
                    
                    
                }label: {
                    BigButton(text: "Next", isButtonactive: true)
                }
                
                Spacer().frame(height: 50)
            }
        .navigationBarBackButtonHidden(true)
    }
}

//struct SQuestion_Previews: PreviewProvider {
//    @Binding var progress: CGFloat
//    static var previews: some View {
//        SQuestion(progress: $progress)
//    }
//}
