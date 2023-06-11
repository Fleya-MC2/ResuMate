//
//  AddItemHeaderView.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 10/06/23.
//

import SwiftUI

struct AddItemHeaderView: View {
    var title: String
    
    var isButtonEnabled: Bool
    let onClicked: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            if isButtonEnabled {
                Button {
                    onClicked()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
    }
}

struct AddItemHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemHeaderView(
            title: "test",
            isButtonEnabled: false,
            onClicked: {
            
        })
    }
}
