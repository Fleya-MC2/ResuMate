//
//  Skill.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct SkillView: View {
    @EnvironmentObject var cardLists: CardLists
    @EnvironmentObject var viewModel: ResumeViewModel
    @Environment(\.managedObjectContext) private var moc
    @State var isSubmit: Bool = false
    @State var isButtonActive: Bool = false
    
    var body: some View {
        VStack{
            CustomToolbar2(titleToolbar: "Skill", destination: HomeView(selection: 1))
            Spacer().frame(height: 27)
            TagForm()
            
            BigButton(text: "Submit", isButtonactive: isButtonActive) {
                if isButtonActive == true {
                    saveSkill()
                    isSubmit = true
                    cardLists.isSkillFilled = true
                }
            }
        }
        .onChange(of: viewModel.skills, perform: { skill in
            if viewModel.skills.count > 0 {
                isButtonActive = true
            }
        })
        .navigationDestination(isPresented: $isSubmit, destination: {
            HomeView(selection: 1)
        })
        .navigationBarBackButtonHidden(true)
        .onAppear{
            if viewModel.skills == []{
                viewModel.skills = fetchSkillFromCoreData(context: moc)
            }
        }
    }
    
    func saveSkill() {
        if viewModel.skills != []{
            saveSkillToCoreData(viewModel.skills, context: moc)
        }
    }
}

struct Skill_Previews: PreviewProvider {
    static var previews: some View {
        SkillView()
    }
}
