//
//  DataView.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI



struct DataView: View {
    @State var isHaveOne: Bool = false
    
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
                                .foregroundColor(.darkblue)
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
//                    ForEach(navigationItems) { item in
//                        NavigationLink(value: item) {
//                            CardList(label: item.label, img: item.img, isFilled: false)
//
//                        }
//
//                        .listStyle(.plain)
//                        .navigationBarTitleDisplayMode(.inline)
//                        .navigationDestination(for: NavigationItem.self) { item in
//                            switch item.menu {
//                            case .personaldata:
//                                PersonalData(navigationItemPath: $navigationItemPath)
//                            case .workexp:
//                                WorkExperience(navigationItemPath: $navigationItemPath)
//                           case .skill:
//                                Skill(navigationItemPath: $navigationItemPath)
//                           case .education:
//                                EducationalBackground(navigationItemPath: $navigationItemPath)
//                           case .addworkexp:
//                                AddWorkExp(navigationItemPath: $navigationItemPath)
//                           case .organization:
//                                AddWorkExp(navigationItemPath: $navigationItemPath)
//                           case .achievement:
//                                AddWorkExp(navigationItemPath: $navigationItemPath)
//
//
//                            }
//                        }
//
//                    }
                    Spacer().frame(height: 20)
                    NavigationLink{
                        PersonalDataView()
                    }label: {
                        DataCard(label: "Personal Data", img: "personal-data", isFilled: true)
                    }
                    NavigationLink{
                        WorkExperienceView()
                    }label: {
                        DataCard(label: "Work Experience", img: "work-exp", isFilled: false)
                    }
                    NavigationLink{
                        EducationView()
                    }label: {
                        DataCard(label: "Educational Background", img: "education", isFilled: true)
                    }
                    DataCard(label: "Organization Experience", img: "organization", isFilled: false)
                    DataCard(label: "Skill", img: "skill", isFilled: false)
                    DataCard(label: "Achievement", img: "achievement", isFilled: false)
                    DataCard(label: "Voluntering", img: "voluntering", isFilled: false)
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