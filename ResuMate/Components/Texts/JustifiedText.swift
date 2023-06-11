//
//  JustifiedText.swift
//  ResuMate
//
//  Created by Pahala Sihombing on 10/06/23.
//

import SwiftUI
import UIKit

struct JustifiedText: UIViewRepresentable {
    @Binding var height: CGFloat
    
    var text: String
    var fontSize: CGFloat

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.text = text
        textView.textAlignment = .justified
        textView.backgroundColor = .clear
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: fontSize) // Set the font size

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text

        DispatchQueue.main.async {
            height = uiView.contentSize.height
        }
    }
}
