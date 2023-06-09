//
//  InfoBoxGeneratePhrases.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct InfoCard: View {
    @State var info: String
    var body: some View {
            HStack(alignment: .top){
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.darkBlue)
                Text(info)
                    .foregroundColor(.darkBlue)
                    .font(.system(size: 16))
                    .frame(width: 320)
                    .bold(true)
            }
            .padding()
            .background(Color.mediumDarkGray.opacity(0.4))
            .cornerRadius(10)
            .padding()
    }
}

struct InfoBoxGeneratePhrases_Previews: PreviewProvider {
    static var previews: some View {
        InfoCard(info: "This text area would be fill with instruction how to answer the question every section.")
    }
}
