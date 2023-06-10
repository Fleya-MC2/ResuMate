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
    var body: some View {
        VStack{
            Spacer().frame(height: 88)
            HStack{
                Text(question)
                    .font(.system(size:17, weight: .regular))
                    
                Spacer()
            }
            HStack{
                BaseForm(placeholder: "sss", fill: $fill)
            }
        }
        .padding(.horizontal, 25)
    }
}

struct GeneratePhrasesForm_Previews: PreviewProvider {
    static var previews: some View {
        GeneratePhrasesForm(question: "test", fill: .constant("test"))
    }
}
