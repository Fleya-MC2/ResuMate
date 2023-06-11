//
//  PersonalData.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct PersonalDataView: View {
    //    @Binding var navigationItemPath: [NavigationItem]
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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    

    
    
    var body: some View {
        if isSubmit{
            DataView()
        }else{
            if isGenerate {
                GeneratePhrasesView()
            }
            else{
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
                        VStack(alignment: .leading){
                            HStack{
                                Text("Professional Summary")
                                    .blacktext17()
                                    .fontWeight(.regular)
                                    .padding(.bottom, 10)
                                Spacer()
                                
                                Button{
                                    isSuggestion.toggle()
                                }label: {
                                    HStack{
                                        Text("Suggestion")
                                            .strongblue15()
                                            .fontWeight(.semibold)
                                        Image(systemName: "sparkles")
                                            .foregroundColor(.darkBlue)
                                    }
                                    .padding(.bottom, 10)
                                }
                                
                            }
                            HStack{
                                TextField("String", text: $summary)
                                    .padding(.leading, 20)
                                Spacer()
                                
                            }.background(Rectangle().fill(.white)
                                .frame(height: 48)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                            )
                            .foregroundColor(.black)
                            
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
 
                        BigButton(text: "Submit", isButtonactive: true) {
                            saveBioData()
                            cardLists.isPersonalDataFilled = true
                            isSubmit = true
                        }
                                            .onReceive(timer) { time in
                        
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
                }.sheet(isPresented: $isSuggestion) {
                    SelectItemSheet(
                        text: "Personal Data",
                        isClosedButtonClicked: {
                            isSuggestion = false
                        },
                        isGeneratePhraseButtonEnabled: true,
                        isGeneratePhraseButtonClicked: {
                            cardLists.currentPageView = Page.personalData.rawValue
                            isSuggestion = false
                            isGenerate = true
                        })
                        .presentationDetents([.medium])
                    
                }.navigationBarBackButtonHidden(true)
            }
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
            let newBio = Bio(id: UUID(), firstname: firstname, lastname: lastname, email: email, phone: phone, motto: motto, summary: summary)
        cardLists.bioData.append(newBio)
         print(newBio)
            // Reset form fields
//            firstname = ""
//            lastname = ""
//            email = ""
//            phone = ""
//            motto = ""
//            summary = ""
        }
}

struct PersonalData_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDataView()
    }
}
