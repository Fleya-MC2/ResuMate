//
//  CardList.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct CardList: View {
    @State var label: String
    @State var img: String
    @State var isFilled: Bool
    var body: some View {
        ZStack{
            HStack{
                Text(label)
                    .white17()
                    .bold()
                    
                Spacer()
                Image(img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 52)
                
                
            }
            .padding(.leading, 15)
            .padding(.trailing, 25)
            .frame(width: 325, height: 70)
            .background(isFilled ? .blue : .gray.opacity(0.5))
            .cornerRadius(14)
            .padding(.bottom, 10)
            if isFilled{
                
                HStack{
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.greencheck )
                            .background(Circle().fill(.white))
                }.offset(x:-20, y: -30)
                   
                    
                
                    
                    
            }
        }
        
       
        
    }
}

struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        CardList(label: "Personal Data", img: "personal-data", isFilled: true)
    }
}
