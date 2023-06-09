//
//  PersonalData.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct PersonalDataView: View {
//    @Binding var navigationItemPath: [NavigationItem]

    @State var firstname: String = ""
    @State var lastname: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var motto: String = ""
    @State var summary: String = ""
    @State var isSuggestion: Bool = false
    @State var isGenerate: Bool = false
    
    var body: some View {
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
                        Spacer().frame(height: 33)
                        BigForm(title: "First Name", placeholder: "String", fill: $firstname)
                        BigForm(title: "Last Name", placeholder: "String", fill: $lastname)
                        BigForm(title: "Email", placeholder: "String", fill: $lastname)
                        BigForm(title: "Phone Number", placeholder: "String", fill: $lastname)
                        BigForm(title: "Professional Motto", placeholder: "String", fill: $lastname)
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
                                            .foregroundColor(.strongblue)
                                    }
                                    .padding(.bottom, 10)
                                }
                                
                            }
                            
                            BasedForm(placeholder: "String", fill: $summary)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                    BigButton(text: "Submit", isButtonactive: true)
                }.sheet(isPresented: $isSuggestion) {
                    ModalPersonalDataSubView(isSuggestion: $isSuggestion, isGenerate: $isGenerate)
                        .presentationDetents([.medium])
                
                
                
                
                
            }.navigationBarBackButtonHidden(true)
        }
    }
}

//struct PersonalData_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonalData(navigationItemPath: <#T##Binding<[NavigationItem]>#>)
//    }
//}
