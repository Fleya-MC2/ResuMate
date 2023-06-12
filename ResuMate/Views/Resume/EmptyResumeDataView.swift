//
//  EmptyResumeData.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct EmptyResumeDataView: View {
    var body: some View {
        VStack {
            Image("EmptyResumeData")
                .scaledToFit()
                .frame(width: 154)
            
            Text("Oops, we couldn't find your data. Please provide Your Data first to simplify the resume creation process.")
                .blacktext17()
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mediumDarkGray.opacity(0.4))
    }
}

struct EmptyResumeDataView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyResumeDataView()
    }
}
