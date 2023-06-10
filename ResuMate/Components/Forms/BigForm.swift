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
            BaseForm(placeholder: placeholder, fill: $fill)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
    }
    
}

//struct BigForm_Previews: PreviewProvider {
//    static var previews: some View {
//        BigForm()
//    }
//}
