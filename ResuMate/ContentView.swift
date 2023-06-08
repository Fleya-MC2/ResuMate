//
//  ContentView.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 08/06/23.
//

import SwiftUI
//import CoreData

struct ContentView: View {
    @State private var jobTitle: String = ""
    @State private var accomplishments: [String] = []
    @State private var error: String? = nil
    @State private var isLoading = false
//    @Binding var pdfText: String
    
//    public init(pdfText: Binding<String>) {
//        _pdfText = pdfText
//    }
        let text = """
        Afif Maruf Content Writer
        LinkedIn Profile: linkedin.com/in/afif.maruf afif.maruf@gmail.com | +62 823 4074 9755
        Summary
        I am a fresh graduate who is able to do research, communicate, and have good writing skills. Have a desire to learn, yet striving to enhance writing abilities through relevant courses and be able to adapt well
        Organization
        Writer
        Hello Campus Magazine
        November 2021 to January 2022
        give ideas and ideas then put them into writing wrote many articles
        Research the content to be written
        Secretary of the Mataram University Student Executive Board
        Mataram University Student Executive Board
        March 2020 to October 2021
        Responsible for organizing secretarial facilities and infrastructure Make organizational financial reports
        Provide attendance list
        Education
        Teknik Informatika
        Universitas Mataram
        2019 - 2022
        Volunteer
        Volunteer Teacher
        Sesaot village
        2021 to Present
        Every month, I volunteer to teach children ages 5 to 7 years old how to read and write in English.
    """
    
    private var chatGptService = ChatGptService()
    
    var body: some View {
        VStack {
            TextField("Enter job title", text: $jobTitle)
                .padding()
                .border(Color.gray, width: 0.5)
            Button("Load Data") {
                print(text)
                self.isLoading = true
                chatGptService.fetchSkillsFromTextOnResume(resumeText: text, completion: { result in
                    DispatchQueue.main.async {
                        self.isLoading = false
                        switch result {
                        case .success(let biodata):
                            print(biodata)
                        case .failure(let error):
                            self.error = error.localizedDescription
                        }
                    }
                })
            }
            if isLoading {
                ProgressView()
            } else {
                List(accomplishments, id: \.self) { accomplishment in
                    Text(accomplishment)
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
