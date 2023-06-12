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
        }
        else{
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
                    text: "Work Experience",
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
