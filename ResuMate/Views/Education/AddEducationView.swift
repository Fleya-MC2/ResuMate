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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


    
    
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
                        VStack(alignment: .leading){
                            HStack{
                                Text("Description")
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
                                TextField("String", text: $description)
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
                    SelectItemSheet(text: "Education Background", isClosedButtonClicked: {
                        isSuggestion = false
                    }, isGeneratePhraseButtonEnabled: true) {
                        isGenerate = true
                    }
                    
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
