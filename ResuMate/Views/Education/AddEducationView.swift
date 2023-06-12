//
//  AddEducation.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct AddEducationView: View {
    var inputType: InputType
    
    @EnvironmentObject var cardLists: CardLists
    @EnvironmentObject var viewModel: ResumeViewModel
    @Environment(\.managedObjectContext) private var moc
    
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
    @State var selectedEducation: EducationModel?
    
    @State var suggestionList: [SuggestionModel] = []
    
    var body: some View {

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
                        case .edit:
                            updateEducation()
                            isSubmit = true
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
                SelectItemSheet(
                       selectItemType: .suggestion,
                        position: major,
                       suggestionList: suggestionList,
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
                }
            .sheet(isPresented: $isGenerate) {
                GeneratePhrasesView(
                    position: major) { suggestion in
                        suggestionList = suggestion
                        isGenerate = false
                        isSuggestion = true
                    }
            }
            .navigationBarBackButtonHidden(true)
                                .onAppear{
                    if inputType == .edit{
                        print("on appear edit run")
                        filledEducationData()
                    }
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
    private func filledEducationData(){
        major = selectedEducation?.major ?? ""
        institution = selectedEducation?.institution ?? ""
        startDate = stringToDate(selectedEducation?.startDate ?? "2023") ?? Date()
        endDate = stringToDate(selectedEducation?.endDate ?? "2023") ?? Date()
        score = selectedEducation?.gpa ?? ""
        description = selectedEducation?.description ?? ""
    }
    private func updateFilledStatus() {
        ismajor = !major.isEmpty
        isinstitution = !institution.isEmpty
        
    }
    func createBigForm(title: String, placeholder: String, fill: Binding<String>, isCheck: Binding<Bool>) -> some View {
        BigForm(title: title, placeholder: placeholder, fill: fill, isCheck: isCheck)
            .onChange(of: fill.wrappedValue, perform: { _ in
                updateFilledStatus()
            })
    }
    func saveEducation() {
        let newEducation = EducationModel(id: UUID(), major: major, institution: institution, startDate: dateToString(startDate, format: .yearMonth), endDate: dateToString(endDate, format: .yearMonth), gpa: score, description: description)
        viewModel.education.append(newEducation)
    }
    func updateEducation(){
        selectedEducation?.major = major
        selectedEducation?.institution = institution
        selectedEducation?.gpa = score
        selectedEducation?.startDate = dateToString(startDate, format: .yearMonthDay)
        selectedEducation?.endDate = dateToString(endDate, format: .yearMonthDay)
        selectedEducation?.description = description
        
        if let selectedEducation = selectedEducation, let index = viewModel.education.firstIndex(where: { $0.id!.uuidString == selectedEducation.id!.uuidString }) {
            viewModel.education[index] = selectedEducation
            // Perform any other necessary actions
        }
        
        updateEducationInCoreData(selectedEducation!, context: moc)
    }
}

//struct AddEducation_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEducation()
//    }
//}
