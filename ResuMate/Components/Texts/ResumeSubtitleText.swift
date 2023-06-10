//
//  ResumeSubtitleText.swift
//  ResuMate
//
//  Created by Pahala Sihombing on 10/06/23.
//

import SwiftUI

struct ResumeSubtitleText: View {
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .fontWeight(.medium)
                .fontWeight(.regular)
                .font(.system(size: 9))
        }
    }
}

struct ResumeSubtitleText_Previews: PreviewProvider {
    static var previews: some View {
        ResumeSubtitleText(text: "test")
    }
}
