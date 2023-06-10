//
//  ResumeViewModel.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 09/06/23.
//

import Foundation

class ResumeViewModel: ObservableObject{
    @Published var biodata: BiodataModel?
    @Published var education: [EducationModel] = []
    @Published var workExperience: [WorkExperienceModel] = []
    @Published var organization: [OrganizationModel] = []
    @Published var volunteer: [VolunteerModel] = []
    @Published var achievement: [AchievementModel] = []
    @Published var skills: [String] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var isError: Bool = false
    
    //MARK: Add counter to precise progress view bar
    
    private var chatGptService = ChatGptService()
    
    func fetchDataFromResume(resumeText: String) {
        isLoading = true
        error = nil
        
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    self.chatGptService.fetchBiodataFromTextOnResume(resumeText: resumeText) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let biodata):
                                self.biodata = biodata
                                print(biodata)
                            case .failure(let error):
                                print("Error biodata")
                                self.isError = true
                                self.error = error.localizedDescription
                                
                            }
                        }
                    }
                }
                group.addTask {
                    self.chatGptService.fetchEducationFromTextOnResume(resumeText: resumeText) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let education):
                                self.education = education
                            case .failure(let error):
                                print("Error education")
                                self.isError = true
                                self.error = error.localizedDescription
                            }
                        }
                    }
                }
                group.addTask {
                    self.chatGptService.fetchWorkExperienceFromTextOnResume(resumeText: resumeText) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let workExperience):
                                self.workExperience = workExperience
                            case .failure(let error):
                                print("Error working")
                                self.isError = true
                                self.error = error.localizedDescription
                            }
                        }
                    }
                }
                group.addTask {
                    self.chatGptService.fetchOrganizationFromTextOnResume(resumeText: resumeText) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let organizations):
                                self.organization = organizations
                            case .failure(let error):
                                print("Error organiation")
                                self.isError = true
                                self.error = error.localizedDescription
                            }
                        }
                    }
                }
                group.addTask {
                    self.chatGptService.fetchVolunteerFromTextOnResume(resumeText: resumeText) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let volunteer):
                                self.volunteer = volunteer
                            case .failure(let error):
                                print("Error volunteer")
                                self.isError = true
                                self.error = error.localizedDescription
                            }
                        }
                    }
                }
                group.addTask {
                    self.chatGptService.fetchAchievementFromTextOnResume(resumeText: resumeText) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let achievements):
                                self.achievement = achievements
                            case .failure(let error):
                                print("Error achivement")
                                self.isError = true
                                self.error = error.localizedDescription
                            }
                        }
                    }
                }
                group.addTask {
                    self.chatGptService.fetchSkillsFromTextOnResume(resumeText: resumeText) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let skills):
                                self.skills = skills
                            case .failure(let error):
                                print("Error skill")
                                self.isError = true
                                self.error = error.localizedDescription
                            }
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
