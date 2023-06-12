//
//  AddOrganization.swift
//  ResuMate
//
//  Created by Luthfi Asmara on 10/06/23.
//

import SwiftUI

struct AddOrganization: View {
    var inputType: InputType
    
    @EnvironmentObject var cardLists: CardLists
    @EnvironmentObject var viewModel: ResumeViewModel
    @Environment(\.managedObjectContext) private var moc
    
    @State var position: String = ""
    @State var organization: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var description: String = ""
    @State var isposition: Bool = false
    @State var isorganization: Bool = false
    @State var isdescription: Bool = false
    @State var isSuggestion: Bool = false
    @State var isGenerate: Bool = false
    @State var isSubmit: Bool = false
    @State var isButtonActive: Bool = false
    @State var selectedOrganization: OrganizationModel?
    
    var body: some View {
        if isGenerate {
//            GeneratePhrases(inputType: inputType)
        }
        else{
            VStack{
                ScrollView{
                    VStack{
                        Spacer().frame(height: 50)
                        createBigForm(title: "Position", placeholder: "String", fill: $position, isCheck: $isposition)
                        createBigForm(title: "Organization", placeholder: "String", fill: $organization, isCheck: $isorganization)
                        HStack{
                            DateForm(title: "Start Date", placeholder: "Date", fill: $startDate)
                            DateForm(title: "End Date", placeholder: "Date", fill: $endDate)
                        }
                        
                        AreaForm(
                            title: "Description",
                            fill: $description,
                            isCheck: $isdescription,
                            isSuggestionEnabled: true
                        ) {
                            isSuggestion = true
                        }
                    }
                    
                }
                Spacer()
                
                BigButton(text: "Submit", isButtonactive: isButtonActive) {
                    if isButtonActive{
                        switch inputType {
                        case .add:
                            saveOrganization()
                            isSubmit = true
                        case .edit:
                            updateOrganization()
                            isSubmit = true
                        }
                        
                        
                    }
                }
                .onChange(of: position) { _ in
                    updateButtonActive()
                }
                .onChange(of: organization) { _ in
                    updateButtonActive()
                }
                .onChange(of: description) { _ in
                    updateButtonActive()
                }
            }
            .navigationDestination(isPresented: $isSubmit, destination: {
                OrganizationView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    NavigationLink{
                        OrganizationView()
                    } label:{
                        Image(systemName: "chevron.backward")
                            .frame(height: 17)
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .principal){
                    TitleToolbar(titleToolbar: "\(inputType.rawValue) Organization Experience")
                }
            }
            .sheet(isPresented: $isSuggestion) {
                SelectItemSheet(
                    selectItemType: .suggestion,
                    position: position,
                    text: "Organization Experience",
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
                
            }.navigationBarBackButtonHidden(true)
                .onAppear{
                    if inputType == .edit{
                        print("on appear edit run")
                        filledOrganizationData()
                    }
                }
        }
        
    }
    
    func updateButtonActive() {
        if position != "" &&
            organization != "" &&
            description != "" {
            isButtonActive = true
            print("%%%\(isButtonActive)")
            
        }else{
            isButtonActive = false
        }
    }
    
    private func filledOrganizationData(){
        position = selectedOrganization?.role ?? ""
        organization = selectedOrganization?.organization ?? ""
        startDate = stringToDate(selectedOrganization?.startDate ?? "2023") ?? Date()
        endDate = stringToDate(selectedOrganization?.endDate ?? "2023") ?? Date()
        description = selectedOrganization?.description ?? ""
    }
    private func updateFilledStatus() {
        isposition = !position.isEmpty
        isorganization = !organization.isEmpty
        isdescription = !description.isEmpty
        
    }
    func createBigForm(title: String, placeholder: String, fill: Binding<String>, isCheck: Binding<Bool>) -> some View {
        BigForm(title: title, placeholder: placeholder, fill: fill, isCheck: isCheck)
            .onChange(of: fill.wrappedValue, perform: { _ in
                updateFilledStatus()
            })
    }
    func saveOrganization() {
        let newOrganization = OrganizationModel(role: position, organization: organization, startDate: dateToString(startDate, format: .yearMonthDay), endDate: dateToString(endDate, format: .yearMonthDay), description: description)
        viewModel.organization.append(newOrganization)
    }
    
    func updateOrganization(){
        selectedOrganization?.role = position
        selectedOrganization?.organization = organization
        selectedOrganization?.startDate = dateToString(startDate, format: .yearMonthDay)
        selectedOrganization?.endDate = dateToString(endDate, format: .yearMonthDay)
        selectedOrganization?.description = description
        
        if let selectedOrganization = selectedOrganization, let index = viewModel.organization.firstIndex(where: { $0.id!.uuidString == selectedOrganization.id!.uuidString }) {
            viewModel.organization[index] = selectedOrganization
            // Perform any other necessary actions
        }
        
        updateOrganizationInCoreData(selectedOrganization!, context: moc)
        
    }
    
}
