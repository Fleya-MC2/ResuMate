//
//  AQuestion.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct AQuestionView: View {
    @State var aqAnswer: String = ""
    @Binding var step: Int
    @Binding var progress: CGFloat
    @Binding var currentPage: GeneratePhrasesPage
    @EnvironmentObject var gpAnswer: GeneratePhrasesAnswer
    @State var isButtonActive: Bool = true
    
    var body: some View {
        VStack{
            GeneratePhrasesToolbar(titleToolbar: "Auto Generate Phrases") {
                progress = progress - 0.20
                step = 3
                currentPage = .tQuestion
            }

            InfoCard(info: "Outline the actions you took to address the situation and accomplish the task. Focus on your individual contributions and highlight any relevant skills or abilities.")
            
            StepBar(progress: progress, step: step)
            
            AreaForm(title: "What action did you take to tackle that challenge?", fill: $aqAnswer, isCheck: .constant(false), isSuggestionEnabled: false) {}
            
            Spacer()
            
            BigButton(text: "Next", isButtonactive: true) {
                gpAnswer.aquestion = aqAnswer
                if progress == 1{
                    progress = 1
                }
                else{
                    progress = progress + 0.20
                    currentPage = .rQuestion
                    step = 5
                }
                
            }
            
            Spacer().frame(height: 50)
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct AQuestion_Previews: PreviewProvider {
//    static var previews: some View {
//        AQuestionView(step: <#Binding<Int>#>, progress: <#Binding<CGFloat>#>, currentPage: <#Binding<GeneratePhrasesPage>#>)
//    }
//}
