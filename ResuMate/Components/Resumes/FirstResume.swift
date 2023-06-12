//
//  FirstResume.swift
//  ResuMate
//
//  Created by Pahala Sihombing on 10/06/23.
//

import SwiftUI

struct FirstResume: View {
    @Binding var bioTextHeight: CGFloat
    
    var biodata: BiodataModel
    var workExperiences: [WorkExperienceModel]
    var educations: [EducationModel]
    var organizations: [OrganizationModel]
    var achievements: [AchievementModel]
    var skills: [SkillModel]
    
    let layout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())] // Grid layout

    var body: some View {
//        GeometryReader { geometry in
            VStack{
                VStack {
                    Text("\(biodata.firstName ?? "") \(biodata.lastName ?? "")")
                        .fontWeight(.bold)
                        .font(.system(size: 13))
                    Text("\(biodata.email ?? "") | \(biodata.phoneNumber ?? "")")
                        .font(.system(size: 10))
                }
               
                JustifiedText(
                    height: $bioTextHeight,
                    text: biodata.professionalSummary ?? "", fontSize: 10)
                    .frame(height: bioTextHeight)
                    .font(.system(size: 10))

                
                VStack {
                    HStack {
                        ResumeTitleText(text:"WORK EXPERIENCE")
                    }
                    Divider()
                        .frame(height: 1)
                    .background(.black)
                    
                    ForEach(workExperiences) { workExperience in
                        VStack(alignment: .leading) {
                            HStack{
                                ResumeSubtitleText(text: "\(workExperience.position ?? ""), \(workExperience.company ?? "")")
                                Spacer()
                                ResumeSubtitleText(text: "\(workExperience.startDate ?? "") - \(workExperience.endDate ?? "")")
                            }
                            
                            ResumeDetailText(text: "\(workExperience.description ?? "")")
                        }
                    }
                }
                .padding(.top)
                
                VStack {
                    HStack {
                        ResumeTitleText(text:"EDUCATION")
                    }
                    Divider()
                        .frame(height: 1)
                    .background(.black)
                    
                    ForEach(educations) { education in
                        VStack(alignment: .leading) {
                            HStack{
                                ResumeSubtitleText(text: "\(education.major ?? ""), \(education.institution ?? "")")
                                
                                Spacer()
                                
                                ResumeSubtitleText(text: "\(education.startDate ?? "") - \(education.endDate ?? "" )")
                            }
                            VStack{
                                ResumeDetailText(text: education.description ?? "")
                            }
                        }
                    }

                }
                .padding(.top)
                VStack {
                    ResumeTitleText(text:"ORGANIZATIONS")
                    
                    Divider()
                    .frame(height: 1)
                    .background(.black)
                    
                    ForEach(organizations) { organization in
                        VStack(alignment: .leading) {
                            HStack{
                                ResumeSubtitleText(text: "\(organization.role ?? ""), \(organization.organization ?? "")")
                                Spacer()
                                ResumeSubtitleText(text: "\(organization.startDate ?? "") - \(organization.endDate ?? "")")
                            }
                            VStack{
                                ResumeDetailText(text: organization.description ?? "")
                            }
                        }
                    }
                }
                .padding(.top)
                VStack {
                    ResumeTitleText(text:"ACHIEVEMENT")
                    
                    Divider()
                    .frame(height: 1)
                    .background(.black)
                    
                    ForEach(achievements) { achievement in
                        VStack {
                            HStack{
                                ResumeSubtitleText(text: "- \(achievement.title ?? "")")
                                Spacer()
                                ResumeSubtitleText(text: achievement.year ?? "")
                            }
                            VStack{
                                ResumeDetailText(text: achievement.description ?? "")
                            }
                        }
                    }
                }
                .padding(.top)
                VStack {
                    ResumeTitleText(text:"SKILL")
                    
                    Divider()
                    .frame(height: 1)
                    .background(.black)
                    
                    LazyVGrid(columns: layout, spacing: 20) {
                        ForEach(skills, id: \.self) { skill in
                            ResumeDetailText(text: "- \(skill.title ?? "")")
                        }
                    }
//                    VStack{
//                        HStack{
//                        ResumeSubtitleText(text: "Soft Skill :")
//                        Spacer()
//                        }
//                        HStack{
//                            VStack{
//                                ResumeDetailText(text: "- Kemampuan manajemen waktu")
//                                ResumeDetailText(text: "- Kemampuan berorganisasi")
//                                ResumeDetailText(text: "- Komunikasi")
//                            }
//                            VStack{
//
//                                ResumeDetailText(text: "- Kemampuan menjalin relasi")
//                                ResumeDetailText(text: "- Kemampuan analisis")
//                            }
//                        }
//                    }
//                    VStack{
//                        HStack{
//                        ResumeSubtitleText(text: "Hard Skill :")
//                        Spacer()
//                        }
//                        HStack{
//                            VStack{
//                                ResumeDetailText(text: "- MS Excel")
//                                ResumeDetailText(text: "- MS Powerpoint")
//                                ResumeDetailText(text: "- MS Word")
//                            }
//
//                        }
//                    }

                }
                .padding(.top)
                
                Spacer()
            }


            .aspectRatio(1/1.4142, contentMode: .fill) // A4 aspect ratio
            .scaleEffect(0.7)
//                .frame(width: geometry.size.width * 0.5, height: (geometry.size.width * 0.5) / (210.0 / 297.0))
//                .aspectRatio(210.0 / 297.0, contentMode: .fit)
//        }


    }
}

//struct FirstResume_Previews: PreviewProvider {
//
//    static var previews: some View {
//        FirstResume(bioTextHeight: .constant(0), biodata: BiodataModel(firstName: "Muhammad Adha Fajri", lastName: "Jonison", phoneNumber: "+6289676164742", email: "madhafajrij@gmail.com", professionalMotto: "learn by doing gitu lah pokoknyaa", professionalSummary: "learn by teaching gitu lah pokoknya"), workExperiences: [WorkExperienceModel(position: "Mobile Developer", company: "MHC Asia Group", startDate: "1 Dec 2020", endDate: "5 June 2023", description: "Work")], educations: [EducationModel(major: "Teknik Informatika", institution: "Politeknik Caltex Riau", startDate: "1 Dec 2020", endDate: "1 Dec 2023", gpa: "3.59", description: "Learn by teaching doing teaching")], organizations: [OrganizationModel(role: "Documentation leader", organization: "ITSA", startDate: "1 Dec 202", endDate: "2 Dec 2021", description: "Worked on a project")], achievements: [AchievementModel(title: "2nd place Animation KMIPN", year: "2018")], skills: ["React JS", "Node JS", "Swift", "Swift UI", "UIKIT"])
//    }
//}
