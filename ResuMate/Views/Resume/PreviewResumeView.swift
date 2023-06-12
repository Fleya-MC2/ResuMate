//
//  PreviewResumeView.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 10/06/23.
//

import SwiftUI
import PDFKit

enum ButtonType {
    case select
    case generate
}

struct PreviewResumeView: View {
    @EnvironmentObject var viewModel: ResumeViewModel
    @State private var pdfDocument: PDFDocument?
    
    @State private var bioTextHeight: CGFloat = .zero
    
    @State private var fileURL: URL?
    
    var buttonType: ButtonType
    @Binding var isButtonClicked: Bool
    
    let onCloseClicked: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Text("Preview Resume")
                    .blacktext17()
                    .fontWeight(.semibold)
                
                HStack {
                    Spacer()
                    
                    Button{
                        onCloseClicked()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .background(Circle()
                                .fill(Color.mediumDarkGray)
                                .frame(width: 30, height: 30)
                            )
                    }
                }
            }
            .padding()
            
            Spacer()
            
            if (pdfDocument != nil) {
                PDFDocumentViewer(pdfDocument: pdfDocument!)
                    .edgesIgnoringSafeArea(.all)
                    .padding()
            }
            
            
            BigButton(text: buttonType == .generate ? "Generate Resume" : "Select Template", isButtonactive: true) {
                isButtonClicked = true
                print("[isButtonClicked]", isButtonClicked)
                
                onCloseClicked()
            }
            
        }
        .onAppear{
            generatePDF()
        }
        .onChange(of: bioTextHeight) { textHeight in
            generatePDF()
            
        }
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
        let fileURL = documentsDirectory.appendingPathComponent("YourDocumentName.pdf")
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

struct PreviewResumeView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewResumeView(buttonType: .generate, isButtonClicked: .constant(false), onCloseClicked: {})
    }
}
