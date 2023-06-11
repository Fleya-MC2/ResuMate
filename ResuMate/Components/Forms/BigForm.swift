//
//  BigForm.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct BigForm: View {
    @State var title: String
    @State var placeholder: String
    @Binding var fill: String
    @Binding var isCheck: Bool
    @State var birthdate: Date = Date()
    
    var body: some View{
        
        VStack(alignment: .leading){
            HStack{
                Text(title)
                    .blacktext17()
                    .fontWeight(.regular)
                    .padding(.bottom, 10)
                Spacer()
            }
            Spacer().frame(height: 5)
            HStack{
                TextField(placeholder, text: $fill)
                    .padding(.leading, 20)
                Spacer()
                if isCheck{
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.lightGreen)
                        .padding(.trailing, 15)
                }
            }.background(Rectangle().fill(.white)
                .frame(height: 48)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            )
            .foregroundColor(.black)
//            BasedForm(placeholder: placeholder, fill: $fill, isCheck: $isCheck)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
    }
    
}

struct BigForm_Previews: PreviewProvider {
    static var previews: some View {
        BigForm(title: "TEST", placeholder: "TEST", fill: .constant("fwqrbnwq"), isCheck: .constant(false))
    }
}
