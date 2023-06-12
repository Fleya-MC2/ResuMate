//
//  Skill.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct SkillView: View {
    @EnvironmentObject var viewModel: ResumeViewModel
    @Environment(\.managedObjectContext) private var moc
    @State var isSubmit: Bool = false
    @State var isButtonActive: Bool = false
    
    @State private var skillList: [SkillModel] = []

    var body: some View {
        VStack{
            CustomToolbar2(titleToolbar: "Skill", destination: HomeView(selection: 1))
            Spacer().frame(height: 27)
            TagForm(tags: $skillList)
            
            BigButton(text: "Submit", isButtonactive: isButtonActive) {
                    if isButtonActive == true {
                            saveSkill()
                            isSubmit = true
                    }
                }
        }
        .onChange(of: skillList, perform: { skill in
            if skillList.count > 0 {
                isButtonActive = true
            }
        })
            .navigationDestination(isPresented: $isSubmit, destination: {
                HomeView(selection: 1)
            })
            .navigationBarBackButtonHidden(true)
    }
    
    func saveSkill() {
        if skillList != []{
            saveSkillToCoreData(skillList, context: moc)
        }
    }
}

struct Skill_Previews: PreviewProvider {
    static var previews: some View {
        SkillView()
    }
}
