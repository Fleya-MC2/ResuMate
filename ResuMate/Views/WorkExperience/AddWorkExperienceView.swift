//
//  AddWorkExp.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct AddWorkExperienceView: View {
    var inputType: InputType
    
    @EnvironmentObject var cardLists: CardLists
    @EnvironmentObject var viewModel: ResumeViewModel
    @Environment(\.managedObjectContext) private var moc
    
    @State var position: String = ""
    @State var company: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var description: String = ""
    @State var isposition: Bool = false
    @State var iscompany: Bool = false
    @State var isdescription: Bool = false
    @State var isSuggestion: Bool = false
    @State var isGenerate: Bool = false
    @State var isButtonActive: Bool = false
    @State var isSubmit: Bool = false
    @State var selectedWorkExperience: WorkExperienceModel?
    
    var body: some View {
        if isGenerate {
            GeneratePhrasesView(inputType: inputType)
        } else {
            VStack{
                ScrollView{
                    VStack{
                        Spacer().frame(height: 50)
                        createBigForm(title: "Position", placeholder: "String", fill: $position, isCheck: $isposition)
                        createBigForm(title: "Company", placeholder: "String", fill: $company, isCheck: $iscompany)
                        HStack{
                            DateForm(title: "Start Date", placeholder: "Date", fill: $startDate)
                            DateForm(title: "End Date", placeholder: "Date", fill: $endDate)
                        }
                        
                        AreaForm(title: "Description", fill: $description, isCheck: $isdescription, isSuggestionEnabled: true) {
                            isSuggestion = true
                        }
                    }
                    
                }
                Spacer()
                
                BigButton(text: "Submit", isButtonactive: isButtonActive) {
                    if isButtonActive == true {
                        print("inputType", inputType)
                        switch inputType {
                        case .add:
                            saveWorkExperience()
                            isSubmit = true
                        case .edit:
                            updateWorkExperience()
                            isSubmit = true
                        }
                    }
                }
                .onChange(of: position) { _ in
                    updateButtonActive()
                }
                .onChange(of: company) { _ in
                    updateButtonActive()
                }
                .onChange(of: description) { _ in
                    updateButtonActive()
                }
            }
            .navigationDestination(isPresented: $isSubmit, destination: {
                WorkExperienceView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    NavigationLink{
                        WorkExperienceView()
                    } label:{
                        Image(systemName: "chevron.backward")
                            .frame(height: 17)
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .principal){
                    TitleToolbar(titleToolbar: "\(inputType.rawValue) Work Experience")
                }
            }
            .sheet(isPresented: $isSuggestion) {
                SelectItemSheet(
                    selectItemType: .suggestion,
                    position: position,
                    text: "Work Experience",
                    isGeneratePhraseButtonEnabled: true,
                    onGeneratePhraseButtonClicked: {
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
            .navigationBarBackButtonHidden(true)
            
            .onAppear{
                if inputType == .edit{
                    print("on appear edit run")
                    filledWorkExperienceData()
                }
            }
        }
    }
        

            private func filledWorkExperienceData(){
        position = selectedWorkExperience?.position ?? ""
        company = selectedWorkExperience?.company ?? ""
        startDate = stringToDate(selectedWorkExperience?.startDate ?? "2023") ?? Date()
        endDate = stringToDate(selectedWorkExperience?.endDate ?? "2023") ?? Date()
        description = selectedWorkExperience?.description ?? ""
        
    }
    
    func updateButtonActive() {
        if position != "" &&
            company != "" &&
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
        isposition = !position.isEmpty
        iscompany = !company.isEmpty
        isdescription = !description.isEmpty
        
    }
    func saveWorkExperience() {
        let newWorkExperience = WorkExperienceModel(id: UUID(), position: position, company: company, startDate: dateToString(startDate, format: .yearMonthDay), endDate: dateToString(endDate, format: .yearMonthDay), description: description)
        viewModel.workExperience.append(newWorkExperience)
    }
    func updateWorkExperience(){
        selectedWorkExperience?.position = position
        selectedWorkExperience?.company = company
        selectedWorkExperience?.startDate = dateToString(startDate, format: .yearMonthDay)
        selectedWorkExperience?.endDate = dateToString(endDate, format: .yearMonthDay)
        selectedWorkExperience?.description = description
        
        if let selectedWorkExperience = selectedWorkExperience, let index = viewModel.workExperience.firstIndex(where: { $0.id!.uuidString == selectedWorkExperience.id!.uuidString }) {
            viewModel.workExperience[index] = selectedWorkExperience
            // Perform any other necessary actions
        }
        
        updateWorkExperienceInCoreData(selectedWorkExperience!, context: moc)
    }
    
}

//struct AddWorkExp_Previews: PreviewProvider {
//    static var previews: some View {
//        AddWorkExp()
//    }
//}
