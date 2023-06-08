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
    let temperature = 0
    
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
    
    func fetchSuggestionByJobTitle(jobTitle: String, completion: @escaping (Result<[SuggestionModel], Error>) -> Void) {
        let prompt = "Generate a list of job accomplishments for a \(jobTitle) on a CV in array json format with field name 'suggestion'"
        
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
}



