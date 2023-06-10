//
//  BigButton.swift
//  JobMate
//
//  Created by Luthfi Asmara on 06/06/23.
//

import SwiftUI

struct BigButton: View {
    
    @State var text: String
    @Binding var isButtonactive: Bool
    var body: some View {
        Text(text)
            .white15()
            .fontWeight(.medium)
            .frame(width: 328, height: 50)
            .background(isButtonactive ? Color.lightblue : .grayop)
            .cornerRadius(17)
        
    }
}

//struct BigButton_Previews: PreviewProvider {
//    static var previews: some View {
//        BigButton(text: "Next", isButtonactive: false)
//    }
//}
