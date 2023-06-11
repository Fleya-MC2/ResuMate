//
//  TagCard.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 10/06/23.
//

import SwiftUI

enum TagColor {
    case light
    case dark
}

struct TagCard: View {
    var text: String
    
    var tagColor: TagColor
    
    var onClosed: () -> Void
    
    var body: some View {
        HStack{
            Text(text)
                .foregroundColor(
                    tagColor == .dark
                    ? .black
                    : .darkGray
                )
                
            Button {
                onClosed()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
            }


        }
        .padding( 10)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    tagColor == .dark
                      ? Color.mediumDarkGray
                      : .white
                )
            )
    }
}

struct TagCard_Previews: PreviewProvider {
    static var previews: some View {
        TagCard(text: "test", tagColor: .dark) {}
    }
}
