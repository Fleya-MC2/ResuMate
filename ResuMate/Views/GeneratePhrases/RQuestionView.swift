//
//  RQuestion.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct RQuestionView: View {
    var inputType: InputType
    
    @State var rqAnswer: String = ""
    @Binding var step: Int
    @Binding var progress: CGFloat
    @Binding var currentPage: GeneratePhrasesPage
    @State var isLoading: Bool = false
    @State var isNextPage: Bool = false
    @EnvironmentObject var cardLists: CardLists
    @EnvironmentObject var gpAnswer: GeneratePhrasesAnswer
    @State var isButtonActive: Bool = true
    
    var body: some View {
        if isNextPage{
            switch cardLists.currentPageView {
            case "personalData":
                PersonalDataView(inputType: inputType)
            case "workExp":
                AddWorkExperienceView(inputType: inputType)
            case "education":
                AddEducationView(inputType: inputType)
            case "organization":
                AddOrganization(inputType: inputType)
            case "volunteering":
                AddVolunteering(inputType: inputType)
            case "achievement":
                AddAchievement(inputType: inputType)
            default:
                LoadingScreen()
            }
            
        }else{
            if isLoading{
                LoadingScreen()
            }else{
                
                VStack{
                    GeneratePhrasesToolbar(titleToolbar: "Auto Generate Phrases") {
                        progress = progress - 0.20
                        step = 4
                        currentPage = .aQuestion
                    }
                    
                    InfoCard(info: "Share the outcome or results of your actions. Emphasize the impact you made and quantify your achievements whenever possible.")
                    
                    
                    StepBar(progress: progress, step: step)
                    
                    AreaForm(title: "What was the result of your actions?", fill: $rqAnswer, isCheck: .constant(false), isSuggestionEnabled: false) {}
                    Spacer()
                    
                    BigButton(text: "Submit", isButtonactive: isButtonActive) {
                        gpAnswer.rquestion = rqAnswer
                        isLoading = true
                        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                            withAnimation {
                                saveStarData()
                                isLoading = false
                                isNextPage = true
                            }
                        }
                    }
                    
                    Spacer().frame(height: 50)
                    
                }
                .navigationBarBackButtonHidden(true)
                
            }
        }
    }
    func saveStarData() {
        let newStar = Star(id: UUID(), squestion: gpAnswer.squestion, tquestion: gpAnswer.tquestion, aquestion: gpAnswer.aquestion, rquestion: gpAnswer.rquestion)
        cardLists.starData.append(newStar)
        print(newStar)
    }
}

struct RQuestion_Previews: PreviewProvider {
    static var previews: some View {
        RQuestionView(inputType: .add, step: .constant(0), progress: .constant(0), currentPage: .constant(.aQuestion))
    }
}
