//
//  AddWorkExp.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct AddWorkExp: View {
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
    @State var isButtonActive: Bool = true
    @State var isSubmit: Bool = false




    
    var body: some View {
        if isSubmit{
            WorkExperience()
        } else{
        if isGenerate {
            GeneratePhrases()
        }
        else{
            NavigationStack{
                ScrollView{
                    VStack{
                        Spacer().frame(height: 50)
                        
                        createBigForm(title: "Position", placeholder: "String", fill: $position, isCheck: $isposition)
                        createBigForm(title: "Company", placeholder: "String", fill: $company, isCheck: $iscompany)
                        HStack{
                            DateForm(title: "Start Date", placeholder: "Date", fill: $startDate)
                            DateForm(title: "End Date", placeholder: "Date", fill: $endDate)
                        }
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
                    }
                    Spacer()
                    Button{
                        //                            if isButtonActive == true {
                        saveWorkExp()
                        isSubmit = true
                        //                            }
                        
                    }label: {
                        BigButton(text: "Submit", isButtonactive: isButtonActive)
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        NavigationLink{
                            WorkExperience()
                        } label:{
                            Image(systemName: "chevron.backward")
                                .frame(height: 17)
                                .foregroundColor(.black)
                        }
                    }
                    ToolbarItem(placement: .principal){
                        TitleToolbar(titleToolbar: "Add Work Experience")
                    }
                }
            }.sheet(isPresented: $isSuggestion) {
                ModalWorkExperience(isSuggestion: $isSuggestion, isGenerate: $isGenerate)
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
