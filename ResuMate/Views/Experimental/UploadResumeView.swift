//
//  UploadResumeView.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 09/06/23.
//

import SwiftUI

struct UploadResumeView: View {
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
    
    var body: some View {
        VStack{
            Text("Biodata: \(viewModel.biodata?.professionalSummary ?? "")")
            Text("Education: \(viewModel.education.first?.institution ?? "")")
            
            Button("Fetch Resume Data"){
                viewModel.fetchDataFromResume(resumeText: text)
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            if viewModel.isError{
                Text(viewModel.error ?? "Error cuy")
            }
        }
    }
}

struct UploadResumeView_Previews: PreviewProvider {
    static var previews: some View {
        UploadResumeView()
    }
}
