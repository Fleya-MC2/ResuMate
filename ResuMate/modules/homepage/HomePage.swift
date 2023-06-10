//
//  HomePage.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

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
    @Published var education: [Education] = []
    @Published var achievement: [Achievement] = []
    @Published var workExp: [WorkExp] = []
    @Published var organization: [Organize] = []
    @Published var volunteer: [Volunteer] = []
    @Published var starData: [Star] = []
}



struct HomePage: View {
    @EnvironmentObject var cardLists: CardLists

    @State var selection = 1
    
    
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
        HomePage()
    }
}
