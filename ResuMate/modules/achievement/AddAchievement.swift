//
//  AddAchievement.swift
//  ResuMate
//
//  Created by Luthfi Asmara on 10/06/23.
//

import SwiftUI

struct AddAchievement: View {
    @EnvironmentObject var cardLists: CardLists
    
    @State var achieve: String = ""
    @State var year: String = ""
    @State var isachieve: Bool = false
    @State var isyear: Bool = false
    @State var isSuggestion: Bool = false
    @State var isGenerate: Bool = false
    @State var isSubmit: Bool = false
    @State var isButtonActive: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    
    
    var body: some View {
        if isSubmit{
           AchievementView()
        } else{
            if isGenerate {
                GeneratePhrases()
            }
            else{
                NavigationStack{
                    VStack{
                    ScrollView{
                        VStack{
                            Spacer().frame(height: 50)
                            
                            createBigForm(title: "Achievement", placeholder: "String", fill: $achieve, isCheck: $isachieve)
                            createBigForm(title: "Year of Achievement", placeholder: "String", fill: $year, isCheck: $isyear)
                            
                        }
                        
                    }
                    Spacer()
                    Button{
                                                    if isButtonActive {
                        saveAchievement()
                        isSubmit = true
                                                    }
                        
                    }label: {
                        BigButton(text: "Submit", isButtonactive: $isButtonActive)
                        
                    }
                    .onReceive(timer) { time in
                        
                        if achieve != "" &&
                            year != ""  {
                            isButtonActive = true
                            print("%%%\(isButtonActive)")
                            
                        }else{
                            isButtonActive = false
                        }
                    }
                }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                            NavigationLink{
                                AchievementView()
                            } label:{
                                Image(systemName: "chevron.backward")
                                    .frame(height: 17)
                                    .foregroundColor(.black)
                            }
                        }
                        ToolbarItem(placement: .principal){
                            TitleToolbar(titleToolbar: "Add Achievement")
                        }
                    }
                }.sheet(isPresented: $isSuggestion) {
                    ModalAchievement(isSuggestion: $isSuggestion, isGenerate: $isGenerate)
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
        isachieve = !achieve.isEmpty
        isyear = !year.isEmpty
        
    }
    func saveAchievement() {
        let newAchievement = Achievement(id: UUID(), achieve: achieve, year: year)
        cardLists.achievement.append(newAchievement)
        print(newAchievement)
        
    }
    
}
