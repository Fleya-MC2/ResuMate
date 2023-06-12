//
//  PersonalData.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct PersonalDataView: View {
    var inputType: InputType
    
    @EnvironmentObject var cardLists: CardLists
    @State var firstname: String = ""
    @State var lastname: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var motto: String = ""
    @State var summary: String = ""
    @State var isSuggestion: Bool = false
    @State var isGenerate: Bool = false
    @State var isSubmit: Bool = false
    @State var isfirstname: Bool = false
    @State var islastname: Bool = false
    @State var isemail: Bool = false
    @State var isphone: Bool = false
    @State var ismotto: Bool = false
    @State var issummary: Bool = false
    @State var isButtonActive: Bool = false
    
    var body: some View {
        if isGenerate {
            GeneratePhrasesView(inputType: inputType)
        } else {
            VStack{
                CustomToolbar2(titleToolbar: "Personal Data", destination: HomeView(selection: 1))
                ScrollView{
                    Spacer().frame(height: 17)
                    Text("Borem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.")
                        .blacktext17()
                        .fontWeight(.regular)
                    Spacer().frame(height: 40)
                    createBigForm(title: "First Name", placeholder: "String", fill: $firstname, isCheck: $isfirstname)
                    createBigForm(title: "Last Name", placeholder: "String", fill: $lastname, isCheck: $islastname)
                    createBigForm(title: "Email", placeholder: "String", fill: $email, isCheck: $isemail)
                    createBigForm(title: "Phone Number", placeholder: "String", fill: $phone, isCheck: $isphone)
                    createBigForm(title: "Professional Motto", placeholder: "String", fill: $motto, isCheck: $ismotto)
                    
                    AreaForm(
                        title: "Professional Summary",
                        fill: $summary,
                        isCheck: $issummary,
                        isSuggestionEnabled: true
                    ) {
                        isSuggestion = true
                    }
                    
                    TextEditor(text: $summary)
                        .padding(.leading, 20)
                }
                
                BigButton(text: "Submit", isButtonactive: isButtonActive) {
                    if isButtonActive {
                        switch inputType {
                        case .add:
                            saveBioData()
                            cardLists.isPersonalDataFilled = true
                            isSubmit = true
                        case .edit: break
                            // edit here
                        }
                    }
                }
                .onChange(of: firstname) { _ in updateButtonActive() }
                .onChange(of: lastname) { _ in updateButtonActive() }
                .onChange(of: email) { _ in updateButtonActive() }
                .onChange(of: phone) { _ in updateButtonActive() }
                .onChange(of: motto) { _ in updateButtonActive() }
                .onChange(of: summary) { _ in updateButtonActive() }
            }.sheet(isPresented: $isSuggestion) {
                SelectItemSheet(
                    text: "Personal Data",
                    isGeneratePhraseButtonEnabled: true,
                    onGeneratePhraseButtonClicked: {
                        cardLists.currentPageView = Page.personalData.rawValue
                        isSuggestion = false
                        isGenerate = true
                    },
                    onClosedClicked: {
                        isSuggestion = false
                    },
                    onItemClicked: {
                        
                    })
                .presentationDetents([.medium])
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isSubmit, destination: {
                HomeView(selection: 1)
            })
        }
    }
    
    func updateButtonActive() {
        if firstname != "" &&
            lastname != "" &&
            email != "" &&
            phone != "" &&
            motto != "" &&
            summary != "" {
            isButtonActive = true
            print("%%%\(isButtonActive)")
            
        }else{
            isButtonActive = false
        }
    }
    
    private func updateFilledStatus() {
        isfirstname = !firstname.isEmpty
        islastname = !lastname.isEmpty
        isemail = !email.isEmpty
        isphone = !phone.isEmpty
        ismotto = !motto.isEmpty
        issummary = !summary.isEmpty
    }
    func createBigForm(title: String, placeholder: String, fill: Binding<String>, isCheck: Binding<Bool>) -> some View {
        BigForm(title: title, placeholder: placeholder, fill: fill, isCheck: isCheck)
            .onChange(of: fill.wrappedValue, perform: { _ in
                updateFilledStatus()
            })
    }
    func saveBioData() {
        let newBio = Bio(firstname: firstname, lastname: lastname, email: email, phone: phone, motto: motto, summary: summary)
        cardLists.bioData = newBio
        print(newBio)
    }
}

struct PersonalData_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDataView(inputType: .add)
    }
}
