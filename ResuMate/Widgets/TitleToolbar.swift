//
//  TitleToolbar.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct TitleToolbar: View {
    @State var titleToolbar: String
    var body: some View {
        HStack {
            Text(titleToolbar)
                .blacktext17()
                .fontWeight(.semibold)
        }
    }
}

struct TitleToolbar_Previews: PreviewProvider {
    static var previews: some View {
        TitleToolbar(titleToolbar: "Centered Text")
    }
}
