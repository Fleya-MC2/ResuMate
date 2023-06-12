//
//  AddEducation.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct AddEducationView: View {
    var inputType: InputType
    
//    @Binding var navigationItemPath: [NavigationItem]
    @EnvironmentObject var cardLists: CardLists
    @State var major: String = ""
    @State var institution: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var score: String = ""
    @State var description: String = ""
    @State var ismajor: Bool = false
    @State var isinstitution: Bool = false
    @State var isscore: Bool = false
    @State var isdescription: Bool = false
    @State var isSuggestion: Bool = false
    @State var isGenerate: Bool = false
    @State var isSubmit: Bool = false
    @State var isButtonActive: Bool = false
    
    var body: some View {
            if isGenerate{
                GeneratePhrases(inputType: inputType)
            } else {
                    VStack{
                        CustomToolbar2(titleToolbar: "\(inputType.rawValue) Education", destination: EducationView())
                        createBigForm(title: "Major", placeholder: "String", fill: $major, isCheck: $ismajor)
                        createBigForm(title: "Institution", placeholder: "String", fill: $institution, isCheck: $isinstitution)
                        HStack{
                            DateForm(title: "Start Date", placeholder: "Date", fill: $startDate)
                            DateForm(title: "End Date", placeholder: "Date", fill: $endDate)
                        }
                        createBigForm(title: "GPA/Score", placeholder: "String", fill: $score, isCheck: $isscore)
                        
                        AreaForm(title: "Description", fill: $description, isCheck: $isdescription, isSuggestionEnabled: true) {
                            isSuggestion = true
                        }
                        
                        Spacer()
                        
                        BigButton(text: "Submit", isButtonactive: isButtonActive) {
                                if isButtonActive == true {
                                    switch inputType {
                                    case .add:
                                        saveEducation()
                                        isSubmit = true
                                    case .edit: break
                                        // edit here
                                    }
                                }
                            }
                        .onChange(of: major) { _ in
                            updateButtonActive()
                        }
                        .onChange(of: institution) { _ in
                            updateButtonActive()
                        }
                        .onChange(of: score) { _ in
                            updateButtonActive()
                        }
                        .onChange(of: description) { _ in
                            updateButtonActive()
                        }
                    }
                    .navigationDestination(isPresented: $isSubmit, destination: {
                        EducationView()
                    })
                .sheet(isPresented: $isSuggestion) {
                    let education = EducationModel(major: major, institution: institution, startDate: Helper().dateToString(startDate), endDate: Helper().dateToString(endDate), gpa: "0", description: description)
                    
                    SelectItemSheet(
                        selectItemType: .suggestion,
                        position: major,
                        text: "Education Background",
                        isGeneratePhraseButtonEnabled: true, onGeneratePhraseButtonClicked: {
                        isGenerate = true
                    },
                        onClosedClicked: {
                        isSuggestion = false
                    },
                        onSuggestionItemClicked: {suggestion in
                            description += suggestion
                        },
                        onBiodataItemClicked: {_ in },
                        onWorkExperienceItemClicked: {_ in },
                        onEducationItemClicked: {_ in },
                        onOrganizationItemClicked: {_ in },
                        onSkillItemClicked: {_ in },
                        onAchievementItemClicked: {_ in },
                        onVolunteerItemClicked: {_ in }
                    )
                    .presentationDetents([.medium, .large])
                    
                }.navigationBarBackButtonHidden(true)
            }
        
    }
    
    func updateButtonActive() {
        if major != "" &&
            institution != "" &&
            score != "" &&
            description != "" {
            isButtonActive = true
            print("%%%\(isButtonActive)")
            
        }else{
            isButtonActive = false
        }
    }
    
    func createBigForm(title: String, placeholder: String, fill: Binding<String>, isCheck: Binding<Bool>) -> some View {
        BigForm(title: title, placeholder: placeholder, fill: fill, isCheck: isCheck)
            .onChange(of: fill.wrappedValue, perform: { _ in
                updateFilledStatus()
            })
    }
    private func updateFilledStatus() {
        ismajor = !major.isEmpty
        isinstitution = !institution.isEmpty
        
    }
    func saveEducation() {
        let newEducation = Educationn(id: UUID(), major: major, Institution: institution, startDate: startDate, endDate: endDate, score: score, description: description)
       cardLists.education.append(newEducation)
        print(newEducation)
           // Reset form fields
//            firstname = ""
//            lastname = ""
//            email = ""
//            phone = ""
//            motto = ""
//            summary = ""
       }
}

//struct AddEducation_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEducation()
//    }
//}
