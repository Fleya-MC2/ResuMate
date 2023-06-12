//
//  SaveResumeView.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 11/06/23.
//

import SwiftUI
import PDFKit

struct SaveResumeView: View {
    @EnvironmentObject var viewModel: ResumeViewModel
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
            rootView: FirstResume(
                bioTextHeight: .constant(0), biodata: BiodataModel(firstName: viewModel.biodata?.firstName, lastName: viewModel.biodata?.lastName, phoneNumber: viewModel.biodata?.phoneNumber, email: viewModel.biodata?.email, professionalMotto: viewModel.biodata?.professionalMotto, professionalSummary: viewModel.biodata?.professionalSummary), workExperiences: viewModel.workExperience, educations: viewModel.education, organizations: viewModel.organization, achievements: viewModel.achievement, skills: viewModel.skills)
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
