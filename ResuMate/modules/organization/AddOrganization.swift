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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
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
                        VStack(alignment: .leading){
//                            HStack{
//                                Text("Description")
//                                    .blacktext17()
//                                    .fontWeight(.regular)
//                                    .padding(.bottom, 10)
//                                Spacer()
//
//                                Button{
//                                    isSuggestion.toggle()
//                                }label: {
//                                    HStack{
//                                        Text("Suggestion")
//                                            .strongblue15()
//                                            .fontWeight(.semibold)
//                                        Image(systemName: "sparkles")
//                                            .foregroundColor(.darkBlue)
//                                    }
//                                    .padding(.bottom, 10)
//                                }
//
//                            }
//                            HStack{
                                TextEditor(text: $description)
                                .foregroundColor(Color.gray)
                                  .font(.custom("HelveticaNeue", size: 13))
                                  .lineSpacing(5)
                                  .background(Rectangle().fill(.green))
//                                TextField("String", text: $description)
//                                .lineLimit(5...10)
//                                    .padding(.leading, 20)
//                                Spacer()
                                
//                            }
//                            .background(Rectangle().fill(.white)
//                                .frame(height: 48)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
//                                )
//                            )
//                            .foregroundColor(.black)
                            
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
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
                ModalOrganizationExperience(isSuggestion: $isSuggestion, isGenerate: $isGenerate)
                    .presentationDetents([.medium])
                
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
