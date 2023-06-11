//
//  BigButton.swift
//  JobMate
//
//  Created by Luthfi Asmara on 06/06/23.
//

import SwiftUI

struct BigButton: View {
    
    @State var text: String
    @State var isButtonactive: Bool
    
    var onClicked: () -> Void
    var body: some View {
        Button {
            onClicked()
        } label: {
            Text(text)
                .white15()
                .fontWeight(.medium)
                .frame(width: 328, height: 50)
                .background(isButtonactive ? Color.lightBlue : .mediumDarkGray)
                .cornerRadius(17)
        }
    }
}

struct BigButton_Previews: PreviewProvider {
    static var previews: some View {
        BigButton(text: "Next", isButtonactive: false) {}
    }
}
