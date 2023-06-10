//
//  ResumeDetailText.swift
//  ResuMate
//
//  Created by Pahala Sihombing on 10/06/23.
//

import SwiftUI

struct ResumeDetailText: View {
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .fontWeight(.regular)
                .font(.system(size: 8))
            Spacer()
            
        }
    }
}

struct ResumeDetailText_Previews: PreviewProvider {
    static var previews: some View {
        ResumeDetailText(text: "test")
    }
}
