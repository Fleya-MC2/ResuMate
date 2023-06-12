//
//  AreaForm.swift
//  ResuCreate
//
//  Created by Muhammad Adha Fajri Jonison on 12/06/23.
//

import SwiftUI

struct AreaForm: View {
    @State var title: String
    @Binding var fill: String
    @Binding var isCheck: Bool
    @State var birthdate: Date = Date()
    
    var isSuggestionEnabled: Bool
    let onSuggestionClicked: () -> Void
    
    var body: some View{
        
        VStack(alignment: .leading){
            HStack{
                Text(title)
                    .blacktext17()
                    .fontWeight(.regular)
                    .padding(.bottom, 10)
                Spacer()
                
                if isSuggestionEnabled {
                    Button{
                        onSuggestionClicked()
                    }label: {
                        HStack{
                            Text("Suggestion")
                                .strongblue15()
                                .fontWeight(.semibold)
                            Image(systemName: "sparkles")
                                .foregroundColor(.darkBlue)
                        }
                        .padding(.bottom, 10)
                    }
                }
            }
            
            Spacer().frame(height: 5)
            
            HStack{
                TextEditor(text: $fill)
                    .frame(height: 96)
                    .padding(8)

                Spacer()
                if isCheck{
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.lightGreen)
                        .padding(.trailing, 15)
                }
            }
            .background(Rectangle().fill(.white)
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

struct AreaForm_Previews: PreviewProvider {
    static var previews: some View {
        AreaForm(
            title: "test",
            fill: .constant("test"),
            isCheck: .constant(true),
            isSuggestionEnabled: false
        ) {
                
            }
    }
}
