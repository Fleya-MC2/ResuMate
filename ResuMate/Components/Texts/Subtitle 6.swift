//
//  SubtitleView.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct Subtitle: View {
    @State var subtitle: String

    
    var body: some View {
        HStack{
            Text(subtitle)
                .font(.system(size: 16))
                .foregroundColor(.black)
            Spacer()
        }
    }
}

struct SubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        Subtitle(subtitle:"Hiyaa")
    }
}
