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
                    NavigationLink {
                        UploadResume()
                    } label: {
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
            }
            
            ScrollView(.vertical, showsIndicators: false){
                
                VStack{
                    Spacer().frame(height: 60)
                    Title(title: "Your Data")
                    Subtitle(subtitle: "Checklist all the section below to create your resume or upload your old resume to automatically fill in the data.")
                }.frame(width: 300)
                
                Spacer().frame(height: 55)
                
                Spacer().frame(height: 20)
                NavigationLink{
                    // check if data alerady exist, if exist input type  edit
                    PersonalDataView(inputType: .add)
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
                
                NavigationLink{
                    OrganizationView()
                }label: {
                    DataCard(label: "Organization Experience", img: .organization, isFilled: cardLists.isOrganizationFilled)
                }
                
                NavigationLink{
                    SkillView()
                }label: {
                    DataCard(label: "Skill", img: .skill, isFilled: cardLists.isSkillFilled)
                }
                
                NavigationLink{
                    AchievementView()
                }label: {
                    DataCard(label: "Achievement", img: .achievement, isFilled: cardLists.isAchievementFilled)
                }
                
                NavigationLink{
                    Volunteering()
                }label: {
                    DataCard(label: "Voluntering", img: .volunteering, isFilled: cardLists.isVolunteringFilled)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
