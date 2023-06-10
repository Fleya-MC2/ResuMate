//
//  GeneratePhrasesForm.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct GeneratePhrasesForm: View {
    @State var question: String
    @Binding var fill: String
    @State var placeholder: String = ""
    var body: some View {
        VStack{
            Spacer().frame(height: 88)
            HStack{
                Text(question)
                    .font(.system(size:17, weight: .regular))
                    
                Spacer()
            }
            HStack{
                HStack{
                    TextField(placeholder, text: $fill)
                        .padding(.leading, 20)
                    Spacer()
                    
                }.background(Rectangle().fill(.white)
                    .frame(height: 48)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                )
                .foregroundColor(.black)
//                BasedForm(placeholder: "sss", fill: $fill)
            }
        }
        .padding(.horizontal, 25)
    }
}

//struct GeneratePhrasesForm_Previews: PreviewProvider {
//    static var previews: some View {
//        GeneratePhrasesForm()
//    }
//}
