//
//  ChatGptService.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 08/06/23.
//

import Foundation

class ChatGptService {
    let baseURL = URL(string: "https://api.openai.com/v1/completions")
    let maxTokens = 200
    let temperature = 0.5
    
    private func fetchChatGptApi(prompt: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL?.absoluteString ?? "")") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["model": "text-davinci-003",
                                   "prompt": prompt,
                                   "max_tokens": maxTokens,
                                   "temperature": temperature]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        APIManager.shared.fetchData(request: request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func fetchJobRecommendationSuggestionByJobTitle(jobTitle: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let prompt = """
    Generate a list of job accomplishments for a \(jobTitle) on a CV, where each accomplishment is a sentence that ends with a period. Please do not include any numbering or bullet points:
    """
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let choices = json["choices"] as? [[String: Any]],
                       let text = choices.first?["text"] as? String {
                        var accomplishments = text
                            .components(separatedBy: ".")
                            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                        
                        // If the last sentence is cut-off (does not end with a period), trim it from the results.
                        if !text.hasSuffix(".") {
                            accomplishments.removeLast()
                        }
                        
                        completion(.success(accomplishments))
                    }
                } catch {
                    completion(.failure(error))
                }
                break
            case .failure(let error):
                print(error)
                completion(.failure(error))
                break
            }
        }
        
    }
    
    //MARK: Function to get biodata!
    func fetchBiodataFromTextOnResume(resumeText: String, completion: @escaping (Result<BiodataModel, Error>) -> Void) {
        let prompt = """
    \(resumeText)
    
    From the text above, provide me firstName, lastName, phoneNumber, email, professionalMotto, professionalSummary in JSON format
    """
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let choices = json["choices"] as? [[String: Any]],
                       let text = choices.first?["text"] as? String {
                        let decoder = JSONDecoder()
                        
                        if let completedData = text.data(using: .utf8) {
                            do {
                                let featureData = try decoder.decode(BiodataModel.self, from: completedData)
                                completion(.success(featureData))
                            } catch {
                                print(error)
                                completion(.failure(error))
                            }
                        } else {
                            let error = NSError(domain: "BiodataModel Decoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert completed text to data"])
                            print(error)
                            completion(.failure(error))
                        }
                    } else {
                        let error = NSError(domain: "JSON Parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON data"])
                        print(error)
                        completion(.failure(error))
                    }
                    
                } catch let error {
                    print("run error")
                    completion(.failure(error))
                }
                break
            case .failure(let error):
                print(error)
                completion(.failure(error))
                break
            }
        }
    }
    
    //MARK: Function to get education!
    func fetchEducationFromTextOnResume(resumeText: String, completion: @escaping (Result<[EducationModel], Error>) -> Void) {
        let prompt = """
    \(resumeText)
    
    From the text above, provide me major, institution, startDate, endDate, gpa, description just in education section in array JSON format
    """
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    print("[fetchEducationFromTextOnResume][fetchChatGptApi][data]", data)
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    // Check if the JSON response contains an 'error' key.
                    if let error = json?["error"] as? [String: Any] {
                        let errorMessage = error["message"] as? String ?? "Unknown error occurred"
                        let error = NSError(domain: "ChatGPT API", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        print(error)
                        completion(.failure(error))
                        return
                    }
                    
                    if let choices = json?["choices"] as? [[String: Any]],
                       var text = choices.first?["text"] as? String {
                        print("[fetchEducationFromTextOnResume][fetchChatGptApi][choices]", choices)
                        print("[fetchEducationFromTextOnResume][fetchChatGptApi][text]", text)
                        
                        // Check if the last character is a closing bracket
                        if !text.hasSuffix("]") {
                            // Find the index of the last complete suggestion
                            if let lastIndex = text.lastIndex(of: "}") {
                                // Trim the text to include only complete suggestions and append a closing bracket
                                let endIndex = text.index(after: lastIndex)
                                text = String(text[..<endIndex])
                                text.append("]")
                            }
                        }
                        
                        // Convert the text back to Data for parsing
                        if let jsonData = text.data(using: .utf8) {
                            do {
                                // Decode the data to an array of SuggestionModel
                                let suggestions = try JSONDecoder().decode([EducationModel].self, from: jsonData)
                                completion(.success(suggestions))
                            } catch {
                                print(error)
                                completion(.failure(error))
                            }
                        } else {
                            let error = NSError(domain: "Education Model Decoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert completed text to data"])
                            print(error)
                            completion(.failure(error))
                        }
                    } else {
                        let error = NSError(domain: "JSON Parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON data"])
                        print(error)
                        completion(.failure(error))
                    }
                    
                } catch {
                    completion(.failure(error))
                }
                break
            case .failure(let error):
                print(error)
                completion(.failure(error))
                break
            }
        }
    }
    
    //MARK: Function to get work experience!
    func fetchWorkExperienceFromTextOnResume(resumeText: String, completion: @escaping (Result<[WorkExperienceModel], Error>) -> Void) {
        let prompt = """
    \(resumeText)
    
    From the text above, provide me position, company, startDate, endDate, description just in work experience section in array JSON format
    """
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    print("[fetchWorkExperienceFromTextOnResume][fetchChatGptApi][data]", data)
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    // Check if the JSON response contains an 'error' key.
                    if let error = json?["error"] as? [String: Any] {
                        let errorMessage = error["message"] as? String ?? "Unknown error occurred"
                        let error = NSError(domain: "ChatGPT API", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        print(error)
                        completion(.failure(error))
                        return
                    }
                    
                    if let choices = json?["choices"] as? [[String: Any]],
                       var text = choices.first?["text"] as? String {
                        print("[fetchWorkExperienceFromTextOnResume][fetchChatGptApi][choices]", choices)
                        print("[fetchWorkExperienceFromTextOnResume][fetchChatGptApi][text]", text)
                        
                        // Check if the last character is a closing bracket
                        if !text.hasSuffix("]") {
                            // Find the index of the last complete suggestion
                            if let lastIndex = text.lastIndex(of: "}") {
                                // Trim the text to include only complete suggestions and append a closing bracket
                                let endIndex = text.index(after: lastIndex)
                                text = String(text[..<endIndex])
                                text.append("]")
                            }
                        }
                        
                        // Convert the text back to Data for parsing
                        if let jsonData = text.data(using: .utf8) {
                            do {
                                // Decode the data to an array of SuggestionModel
                                let workExperienceData = try JSONDecoder().decode([WorkExperienceModel].self, from: jsonData)
                                completion(.success(workExperienceData))
                            } catch {
                                print(error)
                                completion(.failure(error))
                            }
                        } else {
                            let error = NSError(domain: "Education Model Decoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert completed text to data"])
                            print(error)
                            completion(.failure(error))
                        }
                    } else {
                        let error = NSError(domain: "JSON Parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON data"])
                        print(error)
                        completion(.failure(error))
                    }
                    
                } catch {
                    completion(.failure(error))
                }
                break
            case .failure(let error):
                print(error)
                completion(.failure(error))
                break
            }
        }
    }
    
    //MARK: Function to get organization!
    func fetchOrganizationFromTextOnResume(resumeText: String, completion: @escaping (Result<[OrganizationModel], Error>) -> Void) {
        let prompt = """
    \(resumeText)
    
    From the text above, provide me role, organization, startDate, endDate, description just in organization section in array JSON format
    """
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    print("[fetchWorkExperienceFromTextOnResume][fetchChatGptApi][data]", data)
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    // Check if the JSON response contains an 'error' key.
                    if let error = json?["error"] as? [String: Any] {
                        let errorMessage = error["message"] as? String ?? "Unknown error occurred"
                        let error = NSError(domain: "ChatGPT API", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        print(error)
                        completion(.failure(error))
                        return
                    }
                    
                    if let choices = json?["choices"] as? [[String: Any]],
                       var text = choices.first?["text"] as? String {
                        print("[fetchWorkExperienceFromTextOnResume][fetchChatGptApi][choices]", choices)
                        print("[fetchWorkExperienceFromTextOnResume][fetchChatGptApi][text]", text)
                        
                        // Check if the last character is a closing bracket
                        if !text.hasSuffix("]") {
                            // Find the index of the last complete suggestion
                            if let lastIndex = text.lastIndex(of: "}") {
                                // Trim the text to include only complete suggestions and append a closing bracket
                                let endIndex = text.index(after: lastIndex)
                                text = String(text[..<endIndex])
                                text.append("]")
                            }
                        }
                        
                        // Convert the text back to Data for parsing
                        if let jsonData = text.data(using: .utf8) {
                            do {
                                // Decode the data to an array of SuggestionModel
                                let organizationData = try JSONDecoder().decode([OrganizationModel].self, from: jsonData)
                                completion(.success(organizationData))
                            } catch {
                                print(error)
                                completion(.failure(error))
                            }
                        } else {
                            let error = NSError(domain: "Organization Model Decoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert completed text to data"])
                            print(error)
                            completion(.failure(error))
                        }
                    } else {
                        let error = NSError(domain: "JSON Parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON data"])
                        print(error)
                        completion(.failure(error))
                    }
                    
                } catch {
                    completion(.failure(error))
                }
                break
            case .failure(let error):
                print(error)
                completion(.failure(error))
                break
            }
        }
    }
    
    //MARK: Function to get volunteer!
    func fetchVolunteerFromTextOnResume(resumeText: String, completion: @escaping (Result<[VolunteerModel], Error>) -> Void) {
        let prompt = """
    \(resumeText)
    
    From the text above, provide me role, organization, startDate, endDate, description just in organization section in array JSON format
    """
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    print("[fetchVolunteerFromTextOnResume][fetchChatGptApi][data]", data)
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    // Check if the JSON response contains an 'error' key.
                    if let error = json?["error"] as? [String: Any] {
                        let errorMessage = error["message"] as? String ?? "Unknown error occurred"
                        let error = NSError(domain: "ChatGPT API", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        print(error)
                        completion(.failure(error))
                        return
                    }
                    
                    if let choices = json?["choices"] as? [[String: Any]],
                       var text = choices.first?["text"] as? String {
                        print("[fetchVolunteerFromTextOnResume][fetchChatGptApi][choices]", choices)
                        print("[fetchVolunteerFromTextOnResume][fetchChatGptApi][text]", text)
                        
                        // Check if the last character is a closing bracket
                        if !text.hasSuffix("]") {
                            // Find the index of the last complete suggestion
                            if let lastIndex = text.lastIndex(of: "}") {
                                // Trim the text to include only complete suggestions and append a closing bracket
                                let endIndex = text.index(after: lastIndex)
                                text = String(text[..<endIndex])
                                text.append("]")
                            }
                        }
                        
                        // Convert the text back to Data for parsing
                        if let jsonData = text.data(using: .utf8) {
                            do {
                                // Decode the data to an array of SuggestionModel
                                let volunteerData = try JSONDecoder().decode([VolunteerModel].self, from: jsonData)
                                completion(.success(volunteerData))
                            } catch {
                                print(error)
                                completion(.failure(error))
                            }
                        } else {
                            let error = NSError(domain: "Volunteer Model Decoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert completed text to data"])
                            print(error)
                            completion(.failure(error))
                        }
                    } else {
                        let error = NSError(domain: "JSON Parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON data"])
                        print(error)
                        completion(.failure(error))
                    }
                    
                } catch {
                    completion(.failure(error))
                }
                break
            case .failure(let error):
                print(error)
                completion(.failure(error))
                break
            }
        }
    }
    
    //MARK: Function to get achivement!
    func fetchAchievementFromTextOnResume(resumeText: String, completion: @escaping (Result<[AchievementModel], Error>) -> Void) {
        let prompt = """
    \(resumeText)
    
    From the text above, provide me title, place, year, description only in achievement section in array JSON format
    """
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    print("[fetchAchievementFromTextOnResume][fetchChatGptApi][data]", data)
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    // Check if the JSON response contains an 'error' key.
                    if let error = json?["error"] as? [String: Any] {
                        let errorMessage = error["message"] as? String ?? "Unknown error occurred"
                        let error = NSError(domain: "ChatGPT API", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        print(error)
                        completion(.failure(error))
                        return
                    }
                    
                    if let choices = json?["choices"] as? [[String: Any]],
                       var text = choices.first?["text"] as? String {
                        print("[fetchAchievementFromTextOnResume][fetchChatGptApi][choices]", choices)
                        print("[fetchAchievementFromTextOnResume][fetchChatGptApi][text]", text)
                        
                        // Check if the last character is a closing bracket
                        if !text.hasSuffix("]") {
                            // Find the index of the last complete suggestion
                            if let lastIndex = text.lastIndex(of: "}") {
                                // Trim the text to include only complete suggestions and append a closing bracket
                                let endIndex = text.index(after: lastIndex)
                                text = String(text[..<endIndex])
                                text.append("]")
                            }
                        }
                        
                        // Convert the text back to Data for parsing
                        if let jsonData = text.data(using: .utf8) {
                            do {
                                // Decode the data to an array of SuggestionModel
                                let achivementData = try JSONDecoder().decode([AchievementModel].self, from: jsonData)
                                completion(.success(achivementData))
                            } catch {
                                print(error)
                                completion(.failure(error))
                            }
                        } else {
                            let error = NSError(domain: "Achivement Model Decoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert completed text to data"])
                            print(error)
                            completion(.failure(error))
                        }
                    } else {
                        let error = NSError(domain: "JSON Parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON data"])
                        print(error)
                        completion(.failure(error))
                    }
                    
                } catch {
                    completion(.failure(error))
                }
                break
            case .failure(let error):
                print(error)
                completion(.failure(error))
                break
            }
        }
    }
    
    //MARK: Function to get skill!
    func fetchSkillsFromTextOnResume(resumeText: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let prompt = """
    \(resumeText)
    
    From the text above, provide me skills in array JSON format
    """
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    print("[fetchAchievementFromTextOnResume][fetchChatGptApi][data]", data)
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    // Check if the JSON response contains an 'error' key.
                    if let error = json?["error"] as? [String: Any] {
                        let errorMessage = error["message"] as? String ?? "Unknown error occurred"
                        let error = NSError(domain: "ChatGPT API", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        print(error)
                        completion(.failure(error))
                        return
                    }
                    
                    if let choices = json?["choices"] as? [[String: Any]],
                       var text = choices.first?["text"] as? String {
                        print("[fetchAchievementFromTextOnResume][fetchChatGptApi][choices]", choices)
                        print("[fetchAchievementFromTextOnResume][fetchChatGptApi][text]", text)
                        
                        // Check if the last character is a closing bracket
                        if !text.hasSuffix("]") {
                            // Find the index of the last complete suggestion
                            if let lastIndex = text.lastIndex(of: "}") {
                                // Trim the text to include only complete suggestions and append a closing bracket
                                let endIndex = text.index(after: lastIndex)
                                text = String(text[..<endIndex])
                                text.append("]")
                            }
                        }
                        
                        // Convert the text back to Data for parsing
                        if let jsonData = text.data(using: .utf8) {
                            do {
                                // Decode the data to an array of SuggestionModel
                                let achivementData = try JSONDecoder().decode([String].self, from: jsonData)
                                completion(.success(achivementData))
                            } catch {
                                print(error)
                                completion(.failure(error))
                            }
                        } else {
                            let error = NSError(domain: "Achivement Model Decoding", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert completed text to data"])
                            print(error)
                            completion(.failure(error))
                        }
                    } else {
                        let error = NSError(domain: "JSON Parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON data"])
                        print(error)
                        completion(.failure(error))
                    }
                    
                } catch {
                    completion(.failure(error))
                }
                break
            case .failure(let error):
                print(error)
                completion(.failure(error))
                break
            }
        }
    }
}



