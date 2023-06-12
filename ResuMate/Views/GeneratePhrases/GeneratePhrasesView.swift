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
    var position: String
    
    @State private var sAnswer: String = ""
    @State private var tAnswer: String = ""
    @State private var aAnswer: String = ""
    @State private var rAnswer: String = ""
    
    @State private var currentPage: GeneratePhrasesPage = .generatePhrases
    @State var progress: CGFloat = 0.2
    @State var step: Int = 1
    
    var onGenerated: ([SuggestionModel]) -> Void
    
    var body: some View {
        VStack{
            switch currentPage {
            case .generatePhrases:
                FirstStepView(step: $step, progress: $progress, currentPage: $currentPage)
            case .sQuestion:
                SQuestionView(step: $step, progress: $progress, currentPage: $currentPage, sAnswer: $sAnswer)
            case .tQuestion:
                TQuestionView(step: $step, progress: $progress, currentPage: $currentPage, tAnswer: $tAnswer)
            case .aQuestion:
                AQuestionView(step: $step, progress: $progress, currentPage: $currentPage, aAnswer: $aAnswer)
            case .rQuestion:
                RQuestionView(
                    step: $step,
                    progress: $progress,
                    currentPage: $currentPage,
                    sAnswer: $sAnswer,
                    tAnswer: $tAnswer,
                    aAnswer: $aAnswer,
                    rAnswer: $rAnswer,
                    position: position) { suggestion in
                        onGenerated(suggestion)
                    }
            }
        }
    }
}
