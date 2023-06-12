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
                            print("goes here")
                            saveWorkExp()
                            isSubmit = true
                        case .edit: break
                            //update
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
        }
        
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
    func saveWorkExp() {
        let newWorkExp = WorkExp(id: UUID(), position: position, company: company, startDate: startDate, endDate: endDate, description: description)
        cardLists.workExp.append(newWorkExp)
        print(newWorkExp)
        
    }
    
}

//struct AddWorkExp_Previews: PreviewProvider {
//    static var previews: some View {
//        AddWorkExp()
//    }
//}
