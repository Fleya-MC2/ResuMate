//
//  BasedForm.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct BasedForm: View {
    @State var placeholder: String
    @Binding var fill: String
    var body: some View {
        HStack{
            TextField(placeholder, text: $fill)
                .padding(.horizontal, 20)
            Spacer()
        }.background(Rectangle().fill(.white)
            .frame(height: 48)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        )
        .foregroundColor(.black)
    }
}


