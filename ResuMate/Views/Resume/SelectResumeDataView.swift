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
                isGeneratePhraseButtonClicked: {},
                onItemClicked: {
                    
                })
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddEducationClicked) {
            SelectItemSheet(
                text: "Work Experience",
                isClosedButtonClicked: {
                    isAddEducationClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {},
                onItemClicked: {
                    
                })
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddOrganizationClicked) {
            SelectItemSheet(
                text: "Organization Experience",
                isClosedButtonClicked: {
                    isAddOrganizationClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {},
                onItemClicked: {
                    
                })
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddVolunteeringClicked) {
            SelectItemSheet(
                text: "Volunteering",
                isClosedButtonClicked: {
                    isAddVolunteeringClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {},
                onItemClicked: {
                    
                })
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddAchievementClicked) {
            SelectItemSheet(
                text: "Achievement",
                isClosedButtonClicked: {
                    isAddAchievementClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {},
                onItemClicked: {
                    
                }
            )
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddSkillClicked) {
            SelectItemSheet(
                text: "Achievement",
                isClosedButtonClicked: {
                    isAddSkillClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {},
                onItemClicked: {
                    
                })
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isAddAchievementClicked) {
            SelectItemSheet(
                text: "Achievement",
                isClosedButtonClicked: {
                    isAddSkillClicked = false
                },
                isGeneratePhraseButtonEnabled: false,
                isGeneratePhraseButtonClicked: {},
                onItemClicked: {
                    
                })
                .presentationDetents([.medium])
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
