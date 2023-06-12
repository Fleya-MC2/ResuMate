//
//  ImageButton.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 11/06/23.
//

import SwiftUI

struct ImageButton: View {
    @State var text: String
    
    var isButtonactive: Bool
    var onClicked: () -> Void
    
    var body: some View {
        Button {
            onClicked()
        } label: {
            HStack {
                Spacer().frame(width: 12)
                
                Text(text)
                    .white15()
                
                Spacer()
                
                Image(systemName: "square.and.arrow.up.fill")
                    .foregroundColor(.white)

                Spacer().frame(width: 12)
            }
            .fontWeight(.medium)
            .padding(.vertical, 12)
            .background(isButtonactive ? Color.mediumBlue : Color.mediumDarkGray)
            .disabled(!isButtonactive)
            .cornerRadius(14)
        }
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(text: "Upload resume", isButtonactive: true, onClicked: {})
    }
}
