//
//  LoadingScreen.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        VStack{
            
            Image("Loading")
                .resizable()
                .scaledToFit()
                .frame(width: 270)
            Spacer().frame(height: 35)
            Text("Loading...")
                .strongblue20()
                .bold()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.1))
        .navigationBarBackButtonHidden(true)
        
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
