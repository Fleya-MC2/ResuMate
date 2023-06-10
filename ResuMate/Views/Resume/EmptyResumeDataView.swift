//
//  EmptyResumeData.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct EmptyResumeDataView: View {
    var body: some View {
        VStack{
            Image("EmptyResumeData")
                .resizable()
                .scaledToFit()
                .frame(width: 154)
            Text("Upss we can’t find your data, please full fill")
                .blacktext17()
                .fontWeight(.medium)
                
            HStack{
                Text("your data first to make resume easier")
                    .blacktext17()
                    .fontWeight(.medium)
                Text("here")
                    .strongblue17()
                    .fontWeight(.bold)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkGray.opacity(0.4))
    }
}

struct EmptyResumeDataView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyResumeDataView()
    }
}
