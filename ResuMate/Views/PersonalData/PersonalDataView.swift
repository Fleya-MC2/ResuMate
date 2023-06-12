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
    @EnvironmentObject var viewModel: ResumeViewModel
    @Environment(\.managedObjectContext) private var moc
    
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
            VStack{
                CustomToolbar2(titleToolbar: "Personal Data", destination: HomeView(selection: 1))
                ScrollView{
                    Spacer().frame(height: 17)
                    Text("Start by filling in the basic information to help employers contact you for the next process.")
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
                        isSuggestionEnabled: false
                    ) { }
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
                .onAppear{
                    filledTextFieldFromViewModel()
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
    
    private func filledTextFieldFromViewModel(){
        if let biodata = viewModel.biodata {
            print("run first")
            firstname = biodata.firstName ?? ""
            lastname = biodata.lastName ?? ""
            email = biodata.email ?? ""
            phone = biodata.phoneNumber ?? ""
            motto = biodata.professionalMotto ?? ""
            summary = biodata.professionalSummary ?? ""
        }else{
            print("run second")
            viewModel.biodata = fetchBiodataFromCoreData(context: moc)
            let biodata = viewModel.biodata
            print(biodata?.firstName ?? "")
            firstname = biodata?.firstName ?? ""
            lastname = biodata?.lastName ?? ""
            email = biodata?.email ?? ""
            phone = biodata?.phoneNumber ?? ""
            motto = biodata?.professionalMotto ?? ""
            summary = biodata?.professionalSummary ?? ""
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
        let newBiodata = BiodataModel(id: UUID(),firstName: firstname, lastName: lastname, phoneNumber: phone, email: email, professionalMotto: motto, professionalSummary: summary)
        
        viewModel.biodata = newBiodata
        
        //save to core data with update
        updateBiodataInCoreData(newBiodata, context: moc)
    }
}

struct PersonalData_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDataView(inputType: .add)
    }
}
