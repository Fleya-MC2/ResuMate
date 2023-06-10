//
//  DataView.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI


struct DataView: View {
    @State var isHaveOne: Bool = false
    @EnvironmentObject var cardLists: CardLists
    
    
    var body: some View {
//        NavigationStack{
            VStack{
                if !isHaveOne{
                    HStack{
                        Spacer()
                        HStack{
                            Text("Upload Resume")
                                .strongblue20()
                                .fontWeight(.semibold)
                            Image(systemName: "square.and.arrow.up.fill")
                                .foregroundColor(.darkBlue)
                        }
                        .padding(.trailing, 20)
                    }
                }
                Spacer().frame(height: 60)
                VStack{
                    Title(title: "Your Data")
                    Subtitle(subtitle: "Ceklist all this section below for create resume now!")
                }.frame(width: 300)
                
                Spacer().frame(height: 55)
                ScrollView(.vertical, showsIndicators: false){
                    Spacer().frame(height: 20)
                    NavigationLink{
                        PersonalDataView()
                    }label: {
                        DataCard(label: "Personal Data", img: .personalData, isFilled: cardLists.isPersonalDataFilled)
                    }
                    
                    NavigationLink{
                        WorkExperienceView()
                    }label: {
                        DataCard(label: "Work Experience", img: .workExperience, isFilled: cardLists.isWorkExpFilled)
                    }
                    
                    NavigationLink{
                        EducationView()
                    }label: {
                        DataCard(label: "Educational Background", img: .education, isFilled: cardLists.isEducationFilled)
                    }
                    
                    
                    DataCard(label: "Organization Experience", img: .organization, isFilled: cardLists.isOrganizationFilled)
                    
                    DataCard(label: "Skill", img: .skill, isFilled: cardLists.isSkillFilled)
                    
                    DataCard(label: "Achievement", img: .achievment, isFilled: cardLists.isAchievementFilled)
                    
                    DataCard(label: "Voluntering", img: .volunteering, isFilled: cardLists.isVolunteringFilled)
                }
            }
//        }.navigationBarBackButtonHidden(true)
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
