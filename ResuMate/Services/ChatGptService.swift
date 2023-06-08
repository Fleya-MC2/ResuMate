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



