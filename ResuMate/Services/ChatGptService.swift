//
//  ChatGptService.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 08/06/23.
//

import Foundation

class ChatGptService {
    private let baseURL = URL(string: "https://api.openai.com/v1/completions")
    private let maxTokens = 200
    private let temperature = 0.3
    
    private func fetchAuthorizationKey(completion: @escaping (String) -> Void) {
        let manager = CloudKitService()
        manager.fetchAuthorizationKey(recordName: "AuthorizationKey") { result in
            switch result {
            case .success(let key):
                print("successkey", key)
                completion(key)
            case .failure(let error):
                completion("")
                print("Failed to fetch key: \(error)")
            }
        }
    }
    
    private func fetchChatGptApi(prompt: String, completion: @escaping (Result<Data, Error>) -> Void) {
        fetchAuthorizationKey { authorizationKey in
            guard let url = URL(string: "\(self.baseURL?.absoluteString ?? "")") else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            print("seautho", authorizationKey)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(authorizationKey)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let json: [String: Any] = ["model": "text-davinci-003",
                                       "prompt": prompt,
                                       "max_tokens": self.maxTokens,
                                       "temperature": self.temperature]
            
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
        
        
    }
    
    func fetchSuggestionByPositionTitle(positionTitle: String, completion: @escaping (Result<[SuggestionModel], Error>) -> Void) {
        let prompt = "Generate a list of position accomplishments for a \(positionTitle) on a CV in array json format with field name 'suggestion'"
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    print("[fetchSuggestionByJobTitle][fetchChatGptApi]")
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
                        print("[fetchSuggestionByJobTitle][fetchChatGptApi][choices]", choices)
                        print("[fetchSuggestionByJobTitle][fetchChatGptApi][text]", text)
                        
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
                                let suggestions = try JSONDecoder().decode([SuggestionModel].self, from: jsonData)
                                completion(.success(suggestions))
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
    
    func fetchSuggestionByStarMethod(jobTitle: String, answer1: String, answer2: String, answer3: String, answer4: String, completion: @escaping (Result<[SuggestionModel], Error>) -> Void) {
        let prompt = """
        \(jobTitle)
        1. Tell us some challenging things based on those experiences? \(answer1)
        2. What's your responsibility in that challenge? \(answer2)
        3. What action did you take to tackle that challenge? \(answer3)
        4. What was the result of your actions? \(answer4)
        
        Generate a list of job accomplishments based on the data i gave above on a CV in array json format with field name "suggestion"
        """
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    print("[fetchSuggestionByJobTitle][fetchChatGptApi]")
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("[fetchSuggestionByJobTitle][fetchChatGptApi][json]", json as Any)
                    
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
                        print("[fetchSuggestionByJobTitle][fetchChatGptApi][choices]", choices)
                        print("[fetchSuggestionByJobTitle][fetchChatGptApi][text]", text)
                        
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
                                let suggestions = try JSONDecoder().decode([SuggestionModel].self, from: jsonData)
                                completion(.success(suggestions))
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
    
    func fetchRelevancyScoreByJobTitle(jobTitle: String, content: String, completion: @escaping (Result<[RelevancyScoreModel], Error>) -> Void) {
        let prompt = """
        \(content)
        
        rate from 0 to 100 if the text above is relevant to \(jobTitle) in a json array format with the only field name 'score'
        """
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    print("[isContentRelevantByJobTitle][fetchChatGptApi]")
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("[isContentRelevantByJobTitle][fetchChatGptApi][json]", json as Any)
                    
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
                        print("[isContentRelevantByJobTitle][fetchChatGptApi][choices]", choices)
                        print("[isContentRelevantByJobTitle][fetchChatGptApi][text]", text)
                        
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
                                let relevancyScore = try JSONDecoder().decode([RelevancyScoreModel].self, from: jsonData)
                                completion(.success(relevancyScore))
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
    
    func fetchSkillSuggestionBySkill(skill: String, completion: @escaping (Result<[SuggestionModel], Error>) -> Void) {
        let prompt = "Suggest associated skills or keywords or the complete word in array json format with the only field name 'suggestion' based on '\(skill)'"
        
        self.fetchChatGptApi(prompt: prompt) { result in
            switch result {
            case .success(let data):
                do {
                    print("[fetchSkillSuggestionBySkill][fetchChatGptApi]")
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("[fetchSkillSuggestionBySkill][fetchChatGptApi][json]", json as Any)
                    
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
                        print("[fetchSkillSuggestionBySkill][fetchChatGptApi][choices]", choices)
                        print("[fetchSkillSuggestionBySkill][fetchChatGptApi][text]", text)
                        
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
                                let suggestions = try JSONDecoder().decode([SuggestionModel].self, from: jsonData)
                                completion(.success(suggestions))
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

    //MARK: You can call function on this file!
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
                                var featureData = try decoder.decode(BiodataModel.self, from: completedData)
                                // Generate and assign UUID to each Model instance
                                featureData.id = UUID()
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
    
    From the text above, provide me major, institution, startDate in Date, endDate in Date, gpa, description just in education section in array JSON format
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
                                var educationData = try JSONDecoder().decode([EducationModel].self, from: jsonData)
                                // Generate and assign UUID to each Model instance
                                educationData = educationData.map { var data = $0; data.id = UUID(); return data }
                                completion(.success(educationData))
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
    
    From the text above, provide me position, company, startDate in Date, endDate in Date, description just in work experience section in array JSON format
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
                                var workExperienceData = try JSONDecoder().decode([WorkExperienceModel].self, from: jsonData)
                                // Generate and assign UUID to each Model instance
                                workExperienceData = workExperienceData.map { var data = $0; data.id = UUID(); return data }
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
    
    From the text above, provide me role, organization, startDate in Date, endDate in Date, description only in organization section in array JSON format
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
                                var organizationData = try JSONDecoder().decode([OrganizationModel].self, from: jsonData)
                                // Generate and assign UUID to each Model instance
                                organizationData = organizationData.map { var data = $0; data.id = UUID(); return data }
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
    
    From the text above, provide me role, place, startDate in Date, endDate in Date, description only in volunteer section in array JSON format
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
                                var volunteerData = try JSONDecoder().decode([VolunteerModel].self, from: jsonData)
                                // Generate and assign UUID to each Model instance
                                volunteerData = volunteerData.map { var data = $0; data.id = UUID(); return data }
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
    
    From the text above, provide me title, year in Date, description only in achievement section in array JSON format
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
                                var achivementData = try JSONDecoder().decode([AchievementModel].self, from: jsonData)
                                // Generate and assign UUID to each Model instance
                                achivementData = achivementData.map { var data = $0; data.id = UUID(); return data }
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
    func fetchSkillsFromTextOnResume(resumeText: String, completion: @escaping (Result<[SkillModel], Error>) -> Void) {
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
                                var skillData = try JSONDecoder().decode([SkillModel].self, from: jsonData)
                                // Generate and assign UUID to each EducationModel instance
                                skillData = skillData.map { var data = $0; data.id = UUID(); return data }
                                completion(.success(skillData))
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



