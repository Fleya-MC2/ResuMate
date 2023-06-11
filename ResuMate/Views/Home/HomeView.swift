//
//  HomePage.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

enum Page: String {
    case personalData = "personalData"
    case workExp = "workExp"
    case education = "education"
}

class CardLists: ObservableObject {
    @AppStorage("isPersonalDataFilled") var isPersonalDataFilled: Bool = false
    @AppStorage("isEducationFilled") var isEducationFilled: Bool = false
    @AppStorage("isWorkExpFilled") var isWorkExpFilled: Bool = false
    @AppStorage("isOrganizationFilled") var isOrganizationFilled: Bool = false
    @AppStorage("isSkillFilled") var isSkillFilled: Bool = false
    @AppStorage("isAchievementFilled") var isAchievementFilled: Bool = false
    @AppStorage("isVolunteringFilled") var isVolunteringFilled: Bool = false
    @AppStorage("currentPageView") var currentPageView: String = ""
    @Published var bioData: [Bio] = []
    @Published var starData: [Star] = []
}

struct HomeView: View {
    @EnvironmentObject var cardLists: CardLists
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
            .accentColor(.darkBlue)
            .colorMultiply(.white)
        }.navigationBarBackButtonHidden(true)
            .onAppear {
                UITabBar.appearance().backgroundColor = .white
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
