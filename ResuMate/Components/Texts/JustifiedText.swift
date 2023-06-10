//
//  JustifiedText.swift
//  ResuMate
//
//  Created by Pahala Sihombing on 10/06/23.
//

import SwiftUI

struct JustifiedText: UIViewRepresentable {
    @Binding var height: CGFloat
    
    var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.text = text
        textView.textAlignment = .justified
        textView.backgroundColor = .clear
        textView.isScrollEnabled = true

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text

        DispatchQueue.main.async {
            height = uiView.contentSize.height
        }
    }
}
