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
    @State var position: String = ""
    @State var organization: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var description: String = "test edit"
    @State var isposition: Bool = false
    @State var isorganization: Bool = false
    @State var isdescription: Bool = false
    @State var isSuggestion: Bool = false
    @State var isGenerate: Bool = false
    @State var isSubmit: Bool = false
    @State var isButtonActive: Bool = false
    
    
    var body: some View {
        
        if isGenerate {
            GeneratePhrases(inputType: inputType)
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
                        case .edit: break
                            // edit here
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
                    text: "Organization Experience",
                    isGeneratePhraseButtonEnabled: true,
                    onGeneratePhraseButtonClicked: {
                    isGenerate = true
                },
                    onClosedClicked: {
                    isSuggestion = false
                },
                     onItemClicked: {
                    
                })
                
            }.navigationBarBackButtonHidden(true)
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
    
    func createBigForm(title: String, placeholder: String, fill: Binding<String>, isCheck: Binding<Bool>) -> some View {
        BigForm(title: title, placeholder: placeholder, fill: fill, isCheck: isCheck)
            .onChange(of: fill.wrappedValue, perform: { _ in
                updateFilledStatus()
            })
    }
    private func updateFilledStatus() {
        isposition = !position.isEmpty
        isorganization = !organization.isEmpty
        isdescription = !description.isEmpty
        
    }
    func saveOrganization() {
        let newOrganization = Organize(id: UUID(), position: position, organization: organization, startDate: startDate, endDate: endDate, description: description)
        cardLists.organization.append(newOrganization)
        print(newOrganization)
        
    }
    
}
