//
//  DateForm.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct DateForm: View {
    @State var title: String
    @State var placeholder: String
    @Binding var fill: Date
    @State var birthdate: Date = Date()
    
    var body: some View{
        
        VStack{
            HStack{
                Text(title)
                    .blacktext17()
                    .fontWeight(.regular)
                    .padding(.bottom, 10)
                Spacer()
            }
            HStack{
                DatePicker(
                    "",
                    selection: $fill,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .foregroundColor(.clear)
                Spacer()
            }.background(Rectangle().fill(.white)
                .frame(width: 160 ,height: 48)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            )
            .foregroundColor(.red)
            
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
    }
}

//struct DateForm_Previews: PreviewProvider {
//    static var previews: some View {
//        DateForm()
//    }
//}
