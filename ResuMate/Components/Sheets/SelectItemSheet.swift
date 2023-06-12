//
//  ModalPersonalData.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

enum SelectItemType {
    case suggestion
    case resumeItem
}

enum ResumeItemType {
    case biodata
    case workExperience
    case education
    case organization
    case skill
    case achievement
    case volunteer
}

struct SelectItemSheet: View {
    @EnvironmentObject var cardLists: CardLists
    
    var selectItemType: SelectItemType
    var resumeItemType: ResumeItemType?
    
    var position: String?
    
    @State private var suggestionList: [SuggestionModel]?
    
    var text: String
    
    var isGeneratePhraseButtonEnabled: Bool
    let onGeneratePhraseButtonClicked: () -> Void
    
    let onClosedClicked: () -> Void
    
    let onSuggestionItemClicked: ((String) -> Void)
    let onBiodataItemClicked: ((BiodataModel) -> Void)
    let onWorkExperienceItemClicked: ((WorkExperienceModel) -> Void)
    let onEducationItemClicked: ((EducationModel) -> Void)
    let onOrganizationItemClicked: ((OrganizationModel) -> Void)
    let onSkillItemClicked: ((String) -> Void)
    let onAchievementItemClicked: ((AchievementModel) -> Void)
    let onVolunteerItemClicked: ((VolunteerModel) -> Void)
    
    let chatGptService: ChatGptService = ChatGptService()
    
    @State private var isLoading: Bool = false
    
    var body: some View {
            VStack{
                HStack{
                    Text(text)
                        .blacktext15()
                        .fontWeight(.semibold)
                    
                    Spacer()
                    Button{
                        onClosedClicked()
                    }label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .background(Circle()
                                .fill(Color.mediumGray)
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            )
                    }
                }.frame(height: 75)
                    .padding(.horizontal, 20)
                Divider()
                Spacer().frame(height: 30)
                
                if isLoading {
                    LoadingScreen()
                } else {
                    ScrollView{
                        switch selectItemType {
                        case .suggestion:
                            if suggestionList?.count ?? 0 > 0 {
                                ForEach(suggestionList!) { suggestion in
                                    Button {
                                        onSuggestionItemClicked(suggestion.suggestion)
                                        onClosedClicked()
                                    } label: {
                                        ItemCard(text: suggestion.suggestion, isShowingThumbsUp: false, isShowingClose: false) {
                                            
                                        }
                                            .padding(.horizontal)
                                    }
                                }
                            }
                        case .resumeItem:
                            if resumeItemType != nil {
                                switch resumeItemType {
                                case .biodata:
                                    //get biodata list
                                    
                                    ForEach(0..<3){_ in
                                        Button {
                                            onBiodataItemClicked(
                                                BiodataModel(firstName: "test", lastName: "test", phoneNumber: "test", email: "test", professionalMotto: "test", professionalSummary: "test")
                                            )
                                            onClosedClicked()
                                        } label: {
                                            ItemCard(text: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid", isShowingThumbsUp: true, isShowingClose: false) {}
                                                .padding(.horizontal)
                                        }
                                    }
                                case .workExperience:
                                    //get work experience list
                                    
                                    ForEach(0..<3){_ in
                                        Button {
                                            onWorkExperienceItemClicked(
                                                WorkExperienceModel(position: "", company: "", startDate: "", endDate: "", description: "")
                                            )
                                            onClosedClicked()
                                        } label: {
                                            ItemCard(text: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid", isShowingThumbsUp: true, isShowingClose: false) {}
                                                .padding(.horizontal)
                                        }
                                    }
                                case .education:
                                    ForEach(0..<3){_ in
                                        Button {
                                            onEducationItemClicked(
                                                EducationModel(major: "", institution: "", startDate: "", endDate: "", gpa: "", description: "")
                                            )
                                            onClosedClicked()
                                        } label: {
                                            ItemCard(text: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid", isShowingThumbsUp: true, isShowingClose: false) {}
                                                .padding(.horizontal)
                                        }
                                    }
                                case .organization:
                                    ForEach(0..<3){_ in
                                        Button {
                                            onOrganizationItemClicked(OrganizationModel(role: "", organization: "", startDate: "", endDate: "", description: ""))
                                            onClosedClicked()
                                        } label: {
                                            ItemCard(text: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid", isShowingThumbsUp: true, isShowingClose: false) {}
                                                .padding(.horizontal)
                                        }
                                    }
                                case .skill:
                                    ForEach(0..<3){_ in
                                        Button {
                                            onSkillItemClicked("")
                                            onClosedClicked()
                                        } label: {
                                            ItemCard(text: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid", isShowingThumbsUp: true, isShowingClose: false) {}
                                                .padding(.horizontal)
                                        }
                                    }
                                case .achievement:
                                    ForEach(0..<3){_ in
                                        Button {
                                            onAchievementItemClicked(AchievementModel(title: "", year: ""))
                                            onClosedClicked()
                                        } label: {
                                            ItemCard(text: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid", isShowingThumbsUp: true, isShowingClose: false) {}
                                                .padding(.horizontal)
                                        }
                                    }
                                case .volunteer:
                                    ForEach(0..<3){_ in
                                        Button {
                                            onVolunteerItemClicked(VolunteerModel())
                                            onClosedClicked()
                                        } label: {
                                            ItemCard(text: "ahbsiddhasbdsabdiasbidubasidbasidbasidbiasbdbasidsabid", isShowingThumbsUp: true, isShowingClose: false) {}
                                                .padding(.horizontal)
                                        }
                                    }
                                    
                                case .none:
                                    Text("Empty Data!")
                                }
                            }
                        }
                        
                        
                    }
                }
                
                Spacer()
                
                if isGeneratePhraseButtonEnabled {
                    BigButton(text: "Need something more?", isButtonactive: true) {
                        onGeneratePhraseButtonClicked()
                        onClosedClicked()
                    }
                }
            }
            .onAppear(perform: {
                switch selectItemType {
                case .suggestion:
                    isLoading = true
                    
                    chatGptService.fetchSuggestionByPositionTitle(positionTitle: position ?? "", completion: { result in
                        isLoading = false
                        
                        switch result {
                        case .success(let suggestionList):
                            self.suggestionList = suggestionList
                        case .failure(_): break
                        }
                    })
                case .resumeItem:
                    isLoading = true
                    let content = getContent()
                    
                    chatGptService.fetchRelevancyScoreByJobTitle(
                        jobTitle: position ?? "",
                        content: content,
                        completion: { result in
                        isLoading = false
                            
//                            switch result {
//                            case .success(let suggestionList):
//                                self.suggestionList = suggestionList
//                            case .failure(_): break
//                            }
                    })
                    

                    
                }
            })
            .background(Color.lightGray)
        
    }
    
    func getContent() -> String {
//                            if resumeItemType != nil {
//                                switch resumeItemType {
//                                case .biodata:
////                                    return String(describing: Bio(firstname: "test")
//
//                                case .workExperience:
////                                    return String(describing: <#T##Subject#>)
//                                case .education:
//
//                                case .organization:
//
//                                case .skill:
//
//                                case .achievement:
//
//                                case .volunteer:
//
//
//                                case .none:
//                                    Text("Empty Data!")
//                                }
//                            }
        
        return "Test"
    }
}

struct SuggestionSheetData_Previews: PreviewProvider {
    var isSuggestion: Bool = false
    static var previews: some View {
        
        SelectItemSheet(
            selectItemType: .suggestion,
            resumeItemType: .workExperience,
            text: "Personal Data",
            isGeneratePhraseButtonEnabled: true,
            onGeneratePhraseButtonClicked: {},
            onClosedClicked: {},
            onSuggestionItemClicked: {_ in },
            onBiodataItemClicked: {_ in },
            onWorkExperienceItemClicked: {_ in },
            onEducationItemClicked: {_ in },
            onOrganizationItemClicked: {_ in },
            onSkillItemClicked: {_ in },
            onAchievementItemClicked: {_ in },
            onVolunteerItemClicked: {_ in }
        )
    }
}
