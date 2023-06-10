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
        VStack{
            Spacer().frame(height: 16)
            HStack(alignment: .top){
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.darkBlue)
                Text(info)
                    .foregroundColor(.darkBlue)
                    .font(.system(size: 16))
                    .frame(width: 320)
            }
            Spacer()
        }
        .frame(width: 368, height: 98)
        .background(Color.darkGray.opacity(0.4))
        .cornerRadius(10)
    }
}

struct InfoBoxGeneratePhrases_Previews: PreviewProvider {
    static var previews: some View {
        InfoCard(info: "This text area would be fill with instruction how to answer the question every section.")
    }
}
