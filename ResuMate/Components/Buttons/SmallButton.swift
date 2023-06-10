//
//  SmallButton.swift
//  JobMate
//
//  Created by Luthfi Asmara on 06/06/23.
//

import SwiftUI

struct SmallButton: View {
    @State var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(.black)
            .frame(width: 156, height: 50)
            .background(text == "Submit" || text == "Next" ? Color.lightBlue : .white)
            .cornerRadius(17)
            .background(RoundedRectangle(cornerRadius: 17).stroke(text == "Back" ? .gray : .white, lineWidth: 2))
    }
}

struct SmallButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallButton(text: "Back")
    }
}
