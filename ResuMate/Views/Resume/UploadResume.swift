//
//  UploadResume.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 11/06/23.
//

import SwiftUI
import PDFKit

struct UploadResume: View {
    @State private var loadingProgress: CGFloat = 0
    @State private var resumeText: String = ""
    
    @State private var isUploadResumeClicked: Bool = false
    
    @State private var uploadStatus: UploadStatus = .loading
    
    @EnvironmentObject var viewModel: ResumeViewModel
    @Environment(\.managedObjectContext) private var moc
    
    var body: some View {
        VStack {
            CustomToolbar2(titleToolbar: "Upload Resume", destination: HomeView(selection: 0))
            
            VStack{
                Subtitle(subtitle: "Ensure that your resume is in PDF format. Avoid exiting or closing the application until the processing is complete.")
            }.frame(width: 300)
            
            Spacer().frame(height: 60)
            
            ImageButton(text: "Upload resume", isButtonactive: !viewModel.isLoading) {
                isUploadResumeClicked = true
            }
            .padding(.horizontal, 36)
            
            if viewModel.isLoading {
                UploadBar(progress: loadingProgress, uploadStatus: uploadStatus)
            }
            
            Spacer()
        }
        .sheet(isPresented: $isUploadResumeClicked) {
            DocumentImporter { url in
                // get pdf data
                resumeText = pdfToText(fromPdf: url)
                // call gpt api
                viewModel.fetchDataFromResume(resumeText: resumeText)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func pdfToText(fromPdf url: URL?) -> String{
        guard let url = url else {
            return ""
        }
        
        let docContent = NSMutableAttributedString()
        if let pdf = PDFDocument(url: url) {
            let pageCount = pdf.pageCount
            
            for i in 0 ..< pageCount {
                guard let page = pdf.page(at: i) else { continue }
                guard let pageContent = page.attributedString else { continue }
                docContent.append(pageContent)
            }
        }
        
        return docContent.string
    }
}

struct UploadResume_Previews: PreviewProvider {
    static var previews: some View {
        UploadResume()
    }
}
