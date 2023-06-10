//
//  AQuestion.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct AQuestion: View {
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
                InfoBoxGeneratePhrases(info: "AQuestion")
                ProgressBar(progress: progress, step: step)
                GeneratePhrasesForm(question: "AQuestion", fill: $aqAnswer)
                
                Spacer()
                Button{
                    gpAnswer.aquestion = aqAnswer
                        if progress == 1{
                            progress = 1
                        }
                        else{
                            progress = progress + 0.20
                            currentPage = .rQuestion
                            step = 5
                        }
                    
                    
                }label: {
                    BigButton(text: "Next", isButtonactive: $isButtonActive)
                }
                
                Spacer().frame(height: 50)
            }
        .navigationBarBackButtonHidden(true)
    }
}

//struct AQuestion_Previews: PreviewProvider {
//    static var previews: some View {
//        AQuestion()
//    }
//}
