//
//  UploadResume.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 11/06/23.
//

import SwiftUI



struct UploadResume: View {
    @State private var loadingProgress: CGFloat = 0
    
    @State private var isUploadResumeClicked: Bool = false
    @State private var isLoading: Bool = false
    
    @State private var uploadStatus: UploadStatus = .loading
    
    var body: some View {
        VStack {
            CustomToolbar2(titleToolbar: "Upload Resume", destination: HomeView(selection: 0))
            
            VStack{
                Subtitle(subtitle: "Make sure your resume are PDF format. When it processing don’t quit from this page or close the apps until finished.")
            }.frame(width: 300)
            
            Spacer().frame(height: 60)
            
            ImageButton(text: "Upload resume", isButtonactive: !isLoading) {
                isUploadResumeClicked = true
            }
            .padding(.horizontal, 36)
            
            if isLoading {
                UploadBar(progress: loadingProgress, uploadStatus: uploadStatus)
            }
            
            Spacer()
        }
        .sheet(isPresented: $isUploadResumeClicked) {
            DocumentImporter { url in
                // get pdf data
                // call gpt api
                
                isLoading = true
                
            }
        }
    }
}

struct UploadResume_Previews: PreviewProvider {
    static var previews: some View {
        UploadResume()
    }
}
