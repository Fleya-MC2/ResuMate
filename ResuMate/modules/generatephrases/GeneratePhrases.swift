//
//  GeneratePhrases.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

enum GeneratePhrasesPage {
    case generatePhrases
    case sQuestion
    case tQuestion
    case aQuestion
    case rQuestion
}

class GeneratePhrasesAnswer: ObservableObject {
    @AppStorage("squestion") var squestion: String = ""
    @AppStorage("tquestion") var tquestion: String = ""
    @AppStorage("aquestion") var aquestion: String = ""
    @AppStorage("rquestion") var rquestion: String = ""
    
}
struct GeneratePhrases: View {
    @State private var currentPage: GeneratePhrasesPage = .generatePhrases
    @State var progress: CGFloat = 0.2
    @State var step: Int = 1
    
    var body: some View {
        VStack{
            switch currentPage {
            case .generatePhrases:
                FirstStep(step: $step, progress: $progress, currentPage: $currentPage)
            case .sQuestion:
                SQuestion(step: $step, progress: $progress, currentPage: $currentPage)
            case .tQuestion:
                TQuestion(step: $step, progress: $progress, currentPage: $currentPage)
            case .aQuestion:
                AQuestion(step: $step, progress: $progress, currentPage: $currentPage)
            case .rQuestion:
                RQuestion(step: $step, progress: $progress, currentPage: $currentPage)
            }
        }
    }
}

struct FirstStep: View{
    @Binding var step: Int
    @Binding var progress: CGFloat
    @Binding var currentPage: GeneratePhrasesPage
    

    var body: some View{
        
            VStack{
                
                CustomToolbar2(titleToolbar: "Auto Generate Phrases", destination: HomePage(selection:1))
                    
                ProgressBar(progress: progress, step: step)
                Image("generate-phrases")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 274)
                Spacer().frame(height: 44)
                Text("We Help You")
                    .font(.system(size: 22))
                    .bold()
                    .foregroundColor(.strongblue)
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



