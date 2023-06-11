//
//  TestCoreDataView.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 10/06/23.
//

import SwiftUI

struct TestCoreDataView: View {
    @State private var testData : [VolunteerModel] = []
    @State private var error: String? = nil
    
    @State private var testFromCore : [VolunteerModel] = []
    @State private var isLoading = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy" // Customize the date format as per your preference
        return formatter
    }
    
    //set text
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
    @StateObject private var viewModel = ResumeViewModel()
    
    //view context
    @Environment(\.managedObjectContext) private var moc
    private var chatGptService = ChatGptService()
    
    var body: some View {
        VStack{
            Spacer()
            if isLoading {
                ProgressView()
            }
            ForEach(testData, id: \.self) { datum in
                Text(datum.role ?? "")
                Text(datum.place ?? "")
                Text(datum.startDate ?? "")
            }
            Spacer()
            if testFromCore != []{
                ForEach(testFromCore) { datum in
                    Text(datum.role ?? "")
                    Text(datum.place ?? "")
                    Text(datum.startDate ?? "")
                }
            }
            Spacer()
            Button("Get data from api"){
                self.isLoading = true
                chatGptService.fetchVolunteerFromTextOnResume(resumeText: text, completion: { result in
                    DispatchQueue.main.async {
                        self.isLoading = false
                        switch result {
                        case .success(let data):
                            self.testData = data
                        case .failure(let error):
                            self.error = error.localizedDescription
                            print("error cuy")
                        }
                    }
                })
            }.buttonStyle(.borderedProminent)
            if testData != []{
                Button("Save data"){
                    saveVolunteerToCoreData(testData, context: moc)
                }.buttonStyle(.borderedProminent)
            }
            Button("Fetch Data"){
                testFromCore = fetchVolunteerFromCoreData(context: moc)
            }
            
        }
    }
}

struct TestCoreDataView_Previews: PreviewProvider {
    static var previews: some View {
        TestCoreDataView()
    }
}
