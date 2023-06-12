//
//  DocumentConverterView.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import SwiftUI
import PDFKit
import UIKit

struct DocumentConverterView: View {
    @State private var pdfText: String = ""
    @State private var isShowingDocumentPicker = false
    @State private var showContentView = false
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("PDF to Text Converter")
                    .font(.title)
                    .padding()
                
                Button(action: {
                    isShowingDocumentPicker = true
                }) {
                    Text("Select PDF")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                //                ScrollView {
                //                    Text(pdfText)
                //                        .padding()
                //                }
            }
            .sheet(isPresented: $isShowingDocumentPicker) {
                DocumentImporter { url in
                    pdfToText(fromPDF: url)
                }
            }
        }
    }
    
    func pdfToText(fromPDF url: URL?) {
        guard let url = url else {
            return
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
        
        pdfText = docContent.string
        
        //        let words = pdfText.components(separatedBy: .whitespacesAndNewlines)
        
        
        showContentView = true // Activate the navigation link to show ContentView
    }
}

struct DocumentConverterView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentConverterView()
    }
}
