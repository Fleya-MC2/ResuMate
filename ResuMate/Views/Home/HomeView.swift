//
//  HomePage.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct HomeView: View {
    @State var selection = 0
    
    var body: some View {
        NavigationStack{
            TabView(selection: $selection) {
                ResumeView().tabItem {
                    VStack{
                        Image(systemName: "doc.fill.badge.plus")
                        Text("Resume")
                    }
                }.tag(0)
                DataView().tabItem {
                    Image(systemName: "person.text.rectangle")
                    Text("Data")
                }.tag(1)
                
            }
//            .background(Color.red)
            .accentColor(.strongblue)
            .colorMultiply(.white)
               
                
               
            
            
        }.navigationBarBackButtonHidden(true)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
