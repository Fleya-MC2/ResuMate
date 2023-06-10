//
//  AddEducation.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct AddEducation: View {
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
        if isSubmit{
            EducationalBackground()
        } else{
            if isGenerate{
                GeneratePhrases()
            } else {
                NavigationStack{
                    VStack{
                        CustomToolbar2(titleToolbar: "Add Education", destination: EducationalBackground())
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
                                            .foregroundColor(.strongblue)
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
                        Button{
                            if isButtonActive == true {
                                saveEducation()
                                isSubmit = true
                            }
                            
                        }label: {
                            BigButton(text: "Submit", isButtonactive: $isButtonActive)
                            
                        }
                        .onReceive(timer) { time in
                            
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
                        
                    }
                    
                    
                    
                    
                }
                .sheet(isPresented: $isSuggestion) {
                    ModalEducation(isSuggestion: $isSuggestion, isGenerate: $isGenerate)
                        .presentationDetents([.medium])
                    
                }.navigationBarBackButtonHidden(true)
            }
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
        let newEducation = Education(id: UUID(), major: major, Institution: institution, startDate: startDate, endDate: endDate, score: score, description: description)
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
