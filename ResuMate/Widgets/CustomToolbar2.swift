//
//  CustomToolbar2.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct CustomToolbar2: View {
    @State var titleToolbar: String
    @State var destination: any View

    var body: some View {
        VStack{
            HStack{
                Spacer().frame(width: 20)
                NavigationLink{
                    AnyView(destination)
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

//struct CustomToolbar2_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomToolbar2(titleToolbar: "String", destination: EducationalBackground())
//            
//    }
//}
