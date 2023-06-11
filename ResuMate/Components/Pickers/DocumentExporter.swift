//
//  DocumentPicker.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 11/06/23.
//

import SwiftUI
import PDFKit

struct DocumentExporter: UIViewControllerRepresentable {
    var urls: [URL]
    var onDismiss: (() -> Void)  // Add this property

    func makeCoordinator() -> Coordinator {
        Coordinator(self, onDismiss: self.onDismiss)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forExporting: urls)
        documentPicker.delegate = context.coordinator
        return documentPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentExporter
        var onDismiss: (() -> Void)  // Add this property

        init(_ parent: DocumentExporter, onDismiss: @escaping (() -> Void)) {
            self.parent = parent
            self.onDismiss = onDismiss
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard urls.first != nil else { return }
            self.onDismiss()
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            self.onDismiss()  // call the callback when the picker is cancelled
        }
    }

}
