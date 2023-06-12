//
//  SaveResumeView.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 11/06/23.
//

import SwiftUI
import PDFKit

struct SaveResumeView: View {
    @State private var pdfDocument: PDFDocument?
    @State private var bioTextHeight: CGFloat = .zero
    
    @State private var fileURL: URL?
    
    @State private var isShowDocumentExporter: Bool = false
    @State private var isBackHomeButtonClicked: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Button {
                    print("[$isShowDocumentExporter]", isShowDocumentExporter)
                    isShowDocumentExporter.toggle()
                } label: {
                    HStack{
                        Text("Save")
                            .strongblue20()
                            .fontWeight(.semibold)
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.darkBlue)
                    }
                    .padding(.trailing, 20)
                }
                .sheet(isPresented: $isShowDocumentExporter) {
                    if let url = fileURL {
                        DocumentExporter(urls: [url]) {
                            generatePDF()
                            isShowDocumentExporter = false
                            print("closed")
                        }
                    }
                }
            }
            
            if (pdfDocument != nil) {
                PDFDocumentViewer(pdfDocument: pdfDocument!)
                    .padding()
            }
            
            BigButton(text: "Back Home", isButtonactive: true) {
                isBackHomeButtonClicked = true
            }
        }
        .onAppear{
            generatePDF()
        }
        .onChange(of: bioTextHeight) { textHeight in
            generatePDF()
        }
        .navigationDestination(isPresented: $isBackHomeButtonClicked, destination: {
            HomeView()
        })
        .navigationBarBackButtonHidden(true)
    }
    
    func generatePDF() {
        let pdfData = createPDF()
        print("pdfData", pdfData)
        
        pdfDocument = PDFDocument(data: pdfData)
    }
    
    func createPDF() -> Data {
        let hostingController = UIHostingController(
            rootView: FirstResume(bioTextHeight: .constant(0), biodata: BiodataModel(firstName: "Muhammad Adha Fajri", lastName: "Jonison", phoneNumber: "+6289676164742", email: "madhafajrij@gmail.com", professionalMotto: "learn by doing gitu lah pokoknyaa", professionalSummary: "learn by teaching gitu lah pokoknya"), workExperiences: [WorkExperienceModel(position: "Mobile Developer", company: "MHC Asia Group", startDate: "1 Dec 2020", endDate: "5 June 2023", description: "Work")], educations: [EducationModel(major: "Teknik Informatika", institution: "Politeknik Caltex Riau", startDate: "1 Dec 2020", endDate: "1 Dec 2023", gpa: "3.59", description: "Learn by teaching doing teaching")], organizations: [OrganizationModel(role: "Documentation leader", organization: "ITSA", startDate: "1 Dec 202", endDate: "2 Dec 2021", description: "Worked on a project")], achievements: [AchievementModel(title: "2nd place Animation KMIPN", year: "2018")], skills: ["React JS", "Node JS", "Swift", "Swift UI", "UIKIT"])
                .scaleEffect(1.35)
        )
        
        let uiView = hostingController.view!
        
        let a4Size = CGSize(width: 595.28, height: 841.89)
        uiView.bounds = CGRect(origin: .zero, size: a4Size)
        
        uiView.layoutIfNeeded()
        
        UIGraphicsBeginImageContext(uiView.bounds.size)
        uiView.drawHierarchy(in: uiView.bounds, afterScreenUpdates: true)
        UIGraphicsEndImageContext()
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, uiView.bounds, nil)
        
        if let pdfContext = UIGraphicsGetCurrentContext() {
            UIGraphicsBeginPDFPage()
            uiView.layer.render(in: pdfContext)
            UIGraphicsEndPDFContext()
        }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("resume.pdf")
        self.fileURL = fileURL
        
        do {
            try pdfData.write(to: fileURL)
            print("PDF write successful")
            print("PDF saved to: \(fileURL)")
        } catch {
            print("Error writing PDF: \(error)")
        }
        
        return pdfData as Data
    }
}

struct SaveResumeView_Previews: PreviewProvider {
    static var previews: some View {
        SaveResumeView()
    }
}
