//
//  ResumeDataView.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 10/06/23.
//

import SwiftUI

struct SelectResumeDataView: View {
    @State private var jobPosition: String = ""
    
    @State private var isAddWorkExperienceClicked: Bool = false
    @State private var isAddEducationClicked: Bool = false
    @State private var isAddOrganizationClicked: Bool = false
    @State private var isAddVolunteeringClicked: Bool = false
    @State private var isAddAchievementClicked: Bool = false
    @State private var isAddSkillClicked: Bool = false
    @State private var isPreviewClicked: Bool = false
    
    @State private var isGenerateResumeButtonClicked: Bool = false
    
    var body: some View {
        VStack {
            CustomToolbar2(titleToolbar: "Select your data", destination: CreateResumeView())
            
            ScrollView {
            VStack{
                Text("Job Position").blacktext17()
                
                ZStack {
                    BaseForm(placeholder: "Write your position you want  to apply", fill: $jobPosition).padding()
                    
                    HStack {
                        Spacer()
                        Image(systemName: "suitcase.fill")
                            .foregroundColor(.darkGray)
                    }
                    .padding(.trailing, 24)
                }
                .padding(.bottom)
                

                    VStack {
                        Spacer()
                        
                        AddAndDisplayItemsView(
                            title: "Profile Data",
                            isButtonEnabled: false,
                            onClicked: {},
                            itemType: .item,
                            items: ["test"],
                            onItemRemoved: {}
                        )
                        .padding(.vertical)
                        
                        AddAndDisplayItemsView(
                            title: "Work Experience",
                            isButtonEnabled: true,
                            onClicked: {
                                isAddWorkExperienceClicked = true
                            },
                            itemType: .item,
                            items: ["test", "Test2"],
                            onItemRemoved: {}
                        )
                        .padding(.vertical)
                        
                        AddAndDisplayItemsView(
                            title: "Education Background",
                            isButtonEnabled: true,
                            onClicked: {
                                isAddEducationClicked = true
                            },
                            itemType: .item,
                            items: ["test", "Test2"],
                            onItemRemoved: {}
                        )
                        .padding(.vertical)
                        
                        AddAndDisplayItemsView(
                            title: "Organization Experience",
                            isButtonEnabled: true,
                            onClicked: {
                                isAddOrganizationClicked = true
                            },
                            itemType: .item,
                            items: ["test", "Test2"],
                            onItemRemoved: {}
                        )
                        .padding(.vertical)
                        
                        AddAndDisplayItemsView(
                            title: "Volunteering",
                            isButtonEnabled: true,
                            onClicked: {
                                isAddVolunteeringClicked = true
                            },
                            itemType: .item,
                            items: ["test", "Test2"],
                            onItemRemoved: {}
                        )
                        .padding(.vertical)
                        
                        AddAndDisplayItemsView(
                            title: "Achievement",
                            isButtonEnabled: true,
                            onClicked: {
                                isAddAchievementClicked = true
                            },
                            itemType: .item,
                            items: ["test", "Test2"],
                            onItemRemoved: {}
                        )
                        .padding(.vertical)
                        
                        AddAndDisplayItemsView(
                            title: "Skill",
                            isButtonEnabled: true,
                            onClicked: {
                                isAddSkillClicked = true
                            },
                            itemType: .tag,
                            items: ["test", "Test2", "dqwklneqw", "eqwklnekwq"],
                            onItemRemoved: {}
                        )
                        .padding(.vertical)

                        
                        BigButton(text: "Preview Resume", isButtonactive: true) {
                            isPreviewClicked = true
                        }
                    }
                    .padding()
                    .background(Color.mediumGray)
                }
            }
        }
        .sheet(isPresented: $isAddWorkExperienceClicked) {
            SelectItemSheet(
                text: "Work Experience",
                isClosedButtonClicked: {
                    isAddWorkExperienceClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {})
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddEducationClicked) {
            SelectItemSheet(
                text: "Work Experience",
                isClosedButtonClicked: {
                    isAddEducationClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {})
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddOrganizationClicked) {
            SelectItemSheet(
                text: "Organization Experience",
                isClosedButtonClicked: {
                    isAddOrganizationClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {})
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddVolunteeringClicked) {
            SelectItemSheet(
                text: "Volunteering",
                isClosedButtonClicked: {
                    isAddVolunteeringClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {})
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddAchievementClicked) {
            SelectItemSheet(
                text: "Achievement",
                isClosedButtonClicked: {
                    isAddAchievementClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {})
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddSkillClicked) {
            SelectItemSheet(
                text: "Achievement",
                isClosedButtonClicked: {
                    isAddSkillClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {})
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddAchievementClicked) {
            SelectItemSheet(
                text: "Achievement",
                isClosedButtonClicked: {
                    isAddSkillClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {})
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isPreviewClicked) {
            PreviewResumeView(isGenerateResumeButtonClicked: $isGenerateResumeButtonClicked, onCloseClicked: {
                isPreviewClicked = false
            })
                .presentationDragIndicator(Visibility.visible)
                
        }
        .navigationDestination(isPresented: $isGenerateResumeButtonClicked, destination: {
            SaveResumeView()
        })
        .navigationBarBackButtonHidden(true)

    }
}

struct ResumeDataView_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectResumeDataView()
    }
}
