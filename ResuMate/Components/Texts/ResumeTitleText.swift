//
//  ResumeTitleText.swift
//  ResuMate
//
//  Created by Pahala Sihombing on 10/06/23.
//

import SwiftUI

struct ResumeTitleText: View {
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .fontWeight(.bold)
                .fontWeight(.regular)
                .font(.system(size: 11))
            Spacer()
            
        }
    }
}

struct ResumeTitleText_Previews: PreviewProvider {
    static var previews: some View {
        ResumeTitleText(text: "test")
    }
}
