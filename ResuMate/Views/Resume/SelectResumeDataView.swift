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
    
    @State private var items: [String] = ["test", "fdqwrt etst"]
    
    @State private var isDataEmpty: Bool = false
    
    var body: some View {
        ZStack {
            if isDataEmpty {
                EmptyResumeDataView()
            } else {
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
                                    items: $items,
                                    itemType: .item,
                                    onItemRemoved: { item in
                                        
                                        if let index = items.firstIndex(of: item) {
                                            items.remove(at: index)
                                        }
                                    }
                                )
                                .padding(.vertical)
                                
                                AddAndDisplayItemsView(
                                    title: "Work Experience",
                                    isButtonEnabled: true,
                                    onClicked: {
                                        isAddWorkExperienceClicked = true
                                    },
                                    items: $items,
                                    itemType: .item,
                                    onItemRemoved: { item in
                                        if let index = items.firstIndex(of: item) {
                                            items.remove(at: index)
                                        }
                                    }
                                )
                                .padding(.vertical)
                                
                                AddAndDisplayItemsView(
                                    title: "Education Background",
                                    isButtonEnabled: true,
                                    onClicked: {
                                        isAddEducationClicked = true
                                    },
                                    items: $items,
                                    itemType: .item,
                                    onItemRemoved: { item in
                                        if let index = items.firstIndex(of: item) {
                                            items.remove(at: index)
                                        }
                                    }
                                )
                                .padding(.vertical)
                                
                                AddAndDisplayItemsView(
                                    title: "Organization Experience",
                                    isButtonEnabled: true,
                                    onClicked: {
                                        isAddOrganizationClicked = true
                                    },
                                    items: $items,
                                    itemType: .item,
                                    onItemRemoved: { item in
                                        if let index = items.firstIndex(of: item) {
                                            items.remove(at: index)
                                        }
                                    }
                                )
                                .padding(.vertical)
                                
                                AddAndDisplayItemsView(
                                    title: "Volunteering",
                                    isButtonEnabled: true,
                                    onClicked: {
                                        isAddVolunteeringClicked = true
                                    },
                                    items: $items,
                                    itemType: .item,
                                    onItemRemoved: { item in
                                        if let index = items.firstIndex(of: item) {
                                            items.remove(at: index)
                                        }
                                    }
                                )
                                .padding(.vertical)
                                
                                AddAndDisplayItemsView(
                                    title: "Achievement",
                                    isButtonEnabled: true,
                                    onClicked: {
                                        isAddAchievementClicked = true
                                    },
                                    items: $items,
                                    itemType: .item,
                                    onItemRemoved: { item in
                                        if let index = items.firstIndex(of: item) {
                                            items.remove(at: index)
                                        }
                                    }
                                )
                                .padding(.vertical)
                                
                                AddAndDisplayItemsView(
                                    title: "Skill",
                                    isButtonEnabled: true,
                                    onClicked: {
                                        isAddSkillClicked = true
                                    },
                                    items: $items,
                                    itemType: .tag,
                                    onItemRemoved: { item in
                                        if let index = items.firstIndex(of: item) {
                                            items.remove(at: index)
                                        }
                                    }
                                )
                                .padding(.vertical)
                                
                                

                            }
                            .padding()
                            .background(Color.mediumGray)
                        }
                    }
                    
                    BigButton(text: "Preview Resume", isButtonactive: true) {
                        isPreviewClicked = true
                    }
                }
            }
        }
        .sheet(isPresented: $isAddWorkExperienceClicked) {
            SelectItemSheet(
                selectItemType: .resumeItem,
                resumeItemType: .workExperience,
                text: "Work Experience",
                isGeneratePhraseButtonEnabled: false,
                onGeneratePhraseButtonClicked: {},
                onClosedClicked: {
                    isAddWorkExperienceClicked = false
                },
                onSuggestionItemClicked: {_ in },
                onBiodataItemClicked: {_ in },
                onWorkExperienceItemClicked: {_ in },
                onEducationItemClicked: {_ in },
                onOrganizationItemClicked: {_ in },
                onSkillItemClicked: {_ in },
                onAchievementItemClicked: {_ in },
                onVolunteerItemClicked: {_ in }
            )
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isAddEducationClicked) {
            SelectItemSheet(
                selectItemType: .resumeItem,
                resumeItemType: .education,
                text: "Work Experience",
                isGeneratePhraseButtonEnabled: false,
                onGeneratePhraseButtonClicked: {},
                onClosedClicked: {
                    isAddEducationClicked = false
                },
                onSuggestionItemClicked: {_ in },
                onBiodataItemClicked: {_ in },
                onWorkExperienceItemClicked: {_ in },
                onEducationItemClicked: {_ in },
                onOrganizationItemClicked: {_ in },
                onSkillItemClicked: {_ in },
                onAchievementItemClicked: {_ in },
                onVolunteerItemClicked: {_ in }
            )
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isAddOrganizationClicked) {
            SelectItemSheet(
                selectItemType: .resumeItem,
                resumeItemType: .organization,
                text: "Organization Experience",
                isGeneratePhraseButtonEnabled: false,
                onGeneratePhraseButtonClicked: {},
                onClosedClicked: {
                    isAddOrganizationClicked = false
                },
                onSuggestionItemClicked: {_ in },
                onBiodataItemClicked: {_ in },
                onWorkExperienceItemClicked: {_ in },
                onEducationItemClicked: {_ in },
                onOrganizationItemClicked: {_ in },
                onSkillItemClicked: {_ in },
                onAchievementItemClicked: {_ in },
                onVolunteerItemClicked: {_ in }
            )
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isAddVolunteeringClicked) {
            SelectItemSheet(
                selectItemType: .resumeItem,
                resumeItemType: .volunteer,
                text: "Volunteering",
                isGeneratePhraseButtonEnabled: false,
                onGeneratePhraseButtonClicked: {},
                onClosedClicked: {
                    isAddVolunteeringClicked = false
                },
                onSuggestionItemClicked: {_ in },
                onBiodataItemClicked: {_ in },
                onWorkExperienceItemClicked: {_ in },
                onEducationItemClicked: {_ in },
                onOrganizationItemClicked: {_ in },
                onSkillItemClicked: {_ in },
                onAchievementItemClicked: {_ in },
                onVolunteerItemClicked: {_ in }
            )
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isAddAchievementClicked) {
            SelectItemSheet(
                selectItemType: .resumeItem,
                resumeItemType: .achievement,
                text: "Achievement",
                isGeneratePhraseButtonEnabled: false,
                onGeneratePhraseButtonClicked: {},
                onClosedClicked: {
                    isAddAchievementClicked = false
                },
                onSuggestionItemClicked: {_ in },
                onBiodataItemClicked: {_ in },
                onWorkExperienceItemClicked: {_ in },
                onEducationItemClicked: {_ in },
                onOrganizationItemClicked: {_ in },
                onSkillItemClicked: {_ in },
                onAchievementItemClicked: {_ in },
                onVolunteerItemClicked: {_ in }
            )
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isAddSkillClicked) {
            SelectItemSheet(
                selectItemType: .resumeItem,
                resumeItemType: .skill,
                text: "Skill",
                isGeneratePhraseButtonEnabled: false,
                onGeneratePhraseButtonClicked: {},
                onClosedClicked: {
                    isAddSkillClicked = false
                },
                onSuggestionItemClicked: {_ in },
                onBiodataItemClicked: {_ in },
                onWorkExperienceItemClicked: {_ in },
                onEducationItemClicked: {_ in },
                onOrganizationItemClicked: {_ in },
                onSkillItemClicked: {_ in },
                onAchievementItemClicked: {_ in },
                onVolunteerItemClicked: {_ in }
            )
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isPreviewClicked) {
            PreviewResumeView(buttonType: .generate, isButtonClicked: $isGenerateResumeButtonClicked, onCloseClicked: {
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
