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
            .frame(width: .infinity)
            .padding(.vertical, 12)
            .background(isButtonactive ? Color.mediumBlue : Color.mediumDarkGray)
            .cornerRadius(14)
        }
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(text: "Upload resume", isButtonactive: true, onClicked: {})
    }
}

/*
 import SwiftUI

 struct BigButton: View {
     
     @State var text: String
     var isButtonactive: Bool
     
     var onClicked: () -> Void
     var body: some View {
         Button {
             onClicked()
         } label: {
             Text(text)
                 .white15()
                 .fontWeight(.medium)
                 .frame(width: 328, height: 50)
                 .background(isButtonactive ? Color.lightBlue : .mediumDarkGray)
                 .cornerRadius(17)
         }
     }
 }

 struct BigButton_Previews: PreviewProvider {
     static var previews: some View {
         BigButton(text: "Next", isButtonactive: false) {}
     }
 }
 */
