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
    @State private var suggestions: [SuggestionModel] = []
    @State private var error: String? = nil
    @State private var isLoading = false
    
    private var chatGptService = ChatGptService()
    
    var body: some View {
        VStack {
            TextField("Enter job title", text: $jobTitle)
                .padding()
                .border(Color.gray, width: 0.5)
            Button("Load Data") {
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
