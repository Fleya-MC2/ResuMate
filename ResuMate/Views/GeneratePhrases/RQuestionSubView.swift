//
//  RQuestion.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct RQuestionSubView: View {
    @State var rqAnswer: String = ""
    @Binding var step: Int
    @Binding var progress: CGFloat
    @Binding var currentPage: GeneratePhrasesPage
    @State var isLoading: Bool = false
    var body: some View {
        if isLoading{
            LoadingScreen()
        }else{
            
                VStack{
                    GeneratePhrasesToolbar(titleToolbar: "Auto Generate Phrases") {
                        progress = progress - 0.20
                        step = 4
                        currentPage = .aQuestion
                    }
                    InfoCard(info: "RQuestion")
                    ProgressBar(progress: progress, step: step)
                    
                    GeneratePhrasesForm(question: "RQuestion", fill: $rqAnswer)
                    Spacer()
                    Button{
                        isLoading = true
                        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                            withAnimation {
                                
                                isLoading = false
                            }
                        }
                    } label: {
                        BigButton(text: "Submit", isButtonactive: true)
                    }
                    Spacer().frame(height: 50)
                    
                }
            .navigationBarBackButtonHidden(true)
                
        }
    }
}

//struct RQuestion_Previews: PreviewProvider {
//    static var previews: some View {
//        RQuestion()
//    }
//}
