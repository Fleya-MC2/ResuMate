//
//  CustomToolbar.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct CustomToolbar: View {
    @State var titleToolbar: String
    @State var destinationL: any View
    @State var destinationT: any View
    var body: some View {
        VStack{
            HStack{
                Spacer().frame(width: 20)
                NavigationLink{
                    AnyView(destinationL)
                } label:{
                    Image(systemName: "chevron.backward")
                        .frame(height: 17)
                        .foregroundColor(.black)
                }
                
                Spacer()
                TitleToolbar(titleToolbar: titleToolbar)
                Spacer()
                
                NavigationLink{
                    AnyView(destinationT)
                } label:{
                    Image(systemName: "plus")
                        .font(.system(size: 17))
                        .foregroundColor(.blue)
                }
                
                Spacer().frame(width: 20)
            }
            Spacer().frame(height: 20)
            Divider()
        }
        
           // Adjust the position of the border
        
    }
}

//struct CustomToolbar_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomToolbar(titleToolbar: "String", destinationL: HomePage(selection: 1), destinationT: AddEducation())
//    }
//}
