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
                ResumeView()
                    .border(width: 0.5, edges: [.bottom], color: .lightGray)
                    .tabItem {

                    VStack{
//                        Divider()
                        Image(systemName: "doc.fill.badge.plus")
                        Text("Resume")
                    }
                }
                .tag(0)

                DataView()
                    .border(width: 0.5, edges: [.bottom], color: .lightGray)
                    .tabItem {
                    Image(systemName: "person.text.rectangle")
                    Text("Data")
                }.tag(1)
            }
            .accentColor(.darkblue)
            .colorMultiply(.white)
        }.navigationBarBackButtonHidden(true)
            .onAppear {
                UITabBar.appearance().backgroundColor = .white
            }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
