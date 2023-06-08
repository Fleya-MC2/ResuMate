//
//  ContentView.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 08/06/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var jobTitle: String = ""
    
    @State private var answer1: String = ""
    @State private var answer2: String = ""
    @State private var answer3: String = ""
    @State private var answer4: String = ""
    
    @State private var skill: String = ""
    @State private var timer: Timer? = nil
    
    @State private var suggestions: [SuggestionModel] = []
    @State private var error: String? = nil
    @State private var isLoading = false
    
    private var chatGptService = ChatGptService()
    
    var body: some View {
        VStack {
            TextField("Enter job title", text: $jobTitle)
                .padding()
                .border(Color.gray, width: 0.5)
            
            Button("Load suggestion") {
                self.isLoading = true
                chatGptService.fetchSuggestionByJobTitle(jobTitle: jobTitle, completion: { result in
                    DispatchQueue.main.async {
                        self.isLoading = false
                        switch result {
                        case .success(let suggestions):
                            self.suggestions = suggestions
                        case .failure(let error):
                            self.error = error.localizedDescription
                        }
                    }
                })
            }
            
            TextField("Enter answer1", text: $answer1)
                .padding()
                .border(Color.gray, width: 0.5)
            TextField("Enter answer2", text: $answer2)
                .padding()
                .border(Color.gray, width: 0.5)
            TextField("Enter answer3", text: $answer3)
                .padding()
                .border(Color.gray, width: 0.5)
            TextField("Enter answer4", text: $answer4)
                .padding()
                .border(Color.gray, width: 0.5)
            
            Button("load suggestion answer") {
                self.isLoading = true
                chatGptService.fetchSuggestionByStarMethod(jobTitle: jobTitle, answer1: answer1, answer2: answer2, answer3: answer3, answer4: answer4, completion: { result in
                    DispatchQueue.main.async {
                        self.isLoading = false
                        switch result {
                        case .success(let suggestions):
                            self.suggestions = suggestions
                        case .failure(let error):
                            self.error = error.localizedDescription
                        }
                    }
                })
            }
            
            TextField("Enter skill", text: $skill)
                .padding()
                .border(Color.gray, width: 0.5)
                .onChange(of: skill) { newValue in
                    timer?.invalidate() // Cancel the existing timer if there is one
                    timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                        print("textfield 2 sec")
                        
                         self.isLoading = true
                         chatGptService.fetchSkillSuggestionBySkill(skill: skill, completion: { result in
                             DispatchQueue.main.async {
                                 self.isLoading = false
                                 switch result {
                                 case .success(let suggestions):
                                     self.suggestions = suggestions
                                 case .failure(let error):
                                     self.error = error.localizedDescription
                                 }
                             }
                         })
                         
                    }
                }
            
            if isLoading {
                ProgressView()
            } else {
                List(suggestions, id: \.self) { suggestion in
                    Text(suggestion.suggestion)
                }
            }
        }
        .padding()
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
