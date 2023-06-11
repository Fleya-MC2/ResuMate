//
//  CustomToolbarButton.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct CustomToolbarButton: View {
    @State var titleToolbar: String
    @State var action: ()-> Void

    var body: some View {
        VStack{
            HStack{
                Spacer().frame(width: 20)
                Button{
                    action()
                } label:{
                    Image(systemName: "chevron.backward")
                        .frame(height: 17)
                        .foregroundColor(.black)
                }
                
                Spacer()
                TitleToolbar(titleToolbar: titleToolbar)
                Spacer()
                
                
                
                Spacer().frame(width: 37)
            }
            Spacer().frame(height: 20)
            Divider()
        }
    }
}

struct CustomToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomToolbarButton(titleToolbar: "test", action: {
            
        })
    }
}
