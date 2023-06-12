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
    @EnvironmentObject var viewModel: ResumeViewModel
    @Environment(\.managedObjectContext) private var moc
    
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
    @State var selectedVolunteer: VolunteerModel?
    
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
                            if isButtonActive {
                                switch inputType {
                                case .add:
                                    saveVolunteer()
                                    isSubmit = true
                                case .edit:
                                    updateVolunteer()
                                    isSubmit = true
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
                    ModalVolunteering(isSuggestion: $isSuggestion, isGenerate: $isGenerate)
                        .presentationDetents([.medium])
                    
                }.navigationBarBackButtonHidden(true)
                    .onAppear{
                        if inputType == .edit{
                            print("on appear edit run")
                            filledVolunteerData()
                        }
                    }
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
    private func filledVolunteerData(){
        position = selectedVolunteer?.role ?? ""
        volunteer = selectedVolunteer?.place ?? ""
        description = selectedVolunteer?.description ?? ""
    }
    func saveVolunteer() {
        let newVolunteer = VolunteerModel(id: UUID(), role: position, place: volunteer, description: description)
        
        viewModel.volunteer.append(newVolunteer)
    }
    func updateVolunteer(){
        selectedVolunteer?.role = position
        selectedVolunteer?.place = volunteer
        selectedVolunteer?.description = description
        
        if let selectedVolunteer = selectedVolunteer, let index = viewModel.volunteer.firstIndex(where: { $0.id!.uuidString == selectedVolunteer.id!.uuidString }) {
            viewModel.volunteer[index] = selectedVolunteer
            // Perform any other necessary actions
        }
        
        updateVolunteerInCoreData(selectedVolunteer!, context: moc)
    }
    
}
