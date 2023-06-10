//
//  TitleView.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct Title: View {
    @State var title: String
    var body: some View {
        HStack{
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
            Spacer()
            
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        Title(title: "Hahahaha")
    }
}
