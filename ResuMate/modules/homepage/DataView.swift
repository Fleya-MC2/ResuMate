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
        NavigationStack{
            VStack{
                if !isHaveOne{
                    HStack{
                        Spacer()
                        HStack{
                            Text("Upload Resume")
                                .strongblue20()
                                .fontWeight(.semibold)
                            Image(systemName: "square.and.arrow.up.fill")
                                .foregroundColor(.strongblue)
                        }
                        .padding(.trailing, 20)
                    }
                }
                
                ScrollView(.vertical, showsIndicators: false){
                    
                VStack{
                    Spacer().frame(height: 60)
                    TitleView(title: "Your Data")
                    SubtitleView(subtitle: "Ceklist all this section below for create resume now!")
                }.frame(width: 300)
//                ForEach(cardLists.bioData) { bio in
//                                VStack(alignment: .leading) {
//                                    Text("Name: \(bio.firstname) \(bio.lastname)").foregroundColor(.black)
//                                    Text("Email: \(bio.email)").foregroundColor(.black)
//                                    Text("Phone: \(bio.phone)").foregroundColor(.black)
//                                    Text("Motto: \(bio.motto)").foregroundColor(.black)
//                                    Text("Summary: \(bio.summary)").foregroundColor(.black)
//                                }
//                }
                Spacer().frame(height: 55)
               
                    Spacer().frame(height: 20)
                    NavigationLink{
                        PersonalData()
                    }label: {
                        CardList(label: "Personal Data", img: "personal-data", isFilled: cardLists.isPersonalDataFilled)
                    }
                    
                    NavigationLink{
                        WorkExperience()
                    }label: {
                        CardList(label: "Work Experience", img: "work-exp", isFilled: cardLists.isWorkExpFilled)
                    }
                    
                    NavigationLink{
                        EducationalBackground()
                    }label: {
                        CardList(label: "Educational Background", img: "education", isFilled: cardLists.isEducationFilled)
                    }
                    
                    NavigationLink{
                        Organization()
                    }label: {
                        CardList(label: "Organization Experience", img: "organization", isFilled: cardLists.isOrganizationFilled)
                    }
                    
                    NavigationLink{
                        Skill()
                    }label: {
                        CardList(label: "Skill", img: "skill", isFilled: cardLists.isSkillFilled)
                    }
                    
                    NavigationLink{
                        AchievementView()
                    }label: {
                        CardList(label: "Achievement", img: "achievement", isFilled: cardLists.isAchievementFilled)
                    }
                    
                    NavigationLink{
                        Volunteering()
                    }label: {
                        CardList(label: "Voluntering", img: "voluntering", isFilled: cardLists.isVolunteringFilled)
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

//struct DataView_Previews: PreviewProvider {
//    static var previews: some View {
//        DataView()
//    }
//}
