//
//  AddVolunteering.swift
//  ResuMate
//
//  Created by Luthfi Asmara on 10/06/23.
//

import SwiftUI

struct AddVolunteering: View {
    var inputType: InputType
    
    @EnvironmentObject var cardLists: CardLists
    @State var position: String = ""
    @State var volunteer: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var description: String = ""
    @State var isposition: Bool = false
    @State var isvolunteer: Bool = false
    @State var isdescription: Bool = false
    @State var isSuggestion: Bool = false
    @State var isGenerate: Bool = false
    @State var isSubmit: Bool = false
    @State var isButtonActive: Bool = false
    
    var body: some View {
        if isSubmit{
            Volunteering()
        }else{
            if isGenerate {
                GeneratePhrases(inputType: inputType)
            }
            else{
                NavigationStack{
                    VStack{
                        ScrollView{
                            VStack{
                                Spacer().frame(height: 50)
                                
                                createBigForm(title: "Position", placeholder: "String", fill: $position, isCheck: $isposition)
                                createBigForm(title: "Volunteer", placeholder: "String", fill: $volunteer, isCheck: $isvolunteer)
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
                                
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("Description")
                                            .blacktext17()
                                            .fontWeight(.regular)
                                            .padding(.bottom, 10)
                                        Spacer()
                                        
                                        
                                        
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
                                if isButtonActive {
                                    switch inputType {
                                    case .add:
                                        saveVolunteer()
                                        isSubmit = true
                                    case .edit: break
                                        // edit here
                                    }
                                    
                                    
                                }
                            }
                        .onChange(of: position) { _ in
                            updateButtonActive()
                        }
                        .onChange(of: volunteer) { _ in
                            updateButtonActive()
                        }
                        .onChange(of: description) { _ in
                            updateButtonActive()
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                            NavigationLink{
                                Volunteering()
                            } label:{
                                Image(systemName: "chevron.backward")
                                    .frame(height: 17)
                                    .foregroundColor(.black)
                            }
                        }
                        ToolbarItem(placement: .principal){
                            TitleToolbar(titleToolbar: "\(inputType.rawValue) Volunteering Experience")
                        }
                    }
                }.sheet(isPresented: $isSuggestion) {
                    SelectItemSheet(
                        text: "Volunteering Experience",
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
    }
    
    func updateButtonActive() {
        if position != "" &&
            volunteer != "" &&
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
        isvolunteer = !volunteer.isEmpty
        isdescription = !description.isEmpty
        
    }
    func saveVolunteer() {
        let newVolunteer = Volunteerr(id: UUID(), position: position, volunteer: volunteer, startDate: startDate, endDate: endDate, description: description)
        cardLists.volunteer.append(newVolunteer)
        print(newVolunteer)
        
    }

}
