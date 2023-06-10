//
//  GeneratePhrasesView.swift
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
struct GeneratePhrasesView: View {
    @State private var currentPage: GeneratePhrasesPage = .generatePhrases
    @State var progress: CGFloat = 0.2
    @State var step: Int = 1
    
    var body: some View {
        VStack{
            switch currentPage {
            case .generatePhrases:
                FirstStepSubView(step: $step, progress: $progress, currentPage: $currentPage)
            case .sQuestion:
                SQuestionSubView(step: $step, progress: $progress, currentPage: $currentPage)
            case .tQuestion:
                TQuestionSubView(step: $step, progress: $progress, currentPage: $currentPage)
            case .aQuestion:
                AQuestionSubView(step: $step, progress: $progress, currentPage: $currentPage)
            case .rQuestion:
                RQuestionSubView(step: $step, progress: $progress, currentPage: $currentPage)
            }
        }
    }
}
