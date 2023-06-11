//
//  Skill.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct SkillView: View {

    var body: some View {
        VStack{
           
            CustomToolbar2(titleToolbar: "Skill", destination: DataView())
            Spacer().frame(height: 27)
            TagForm()
        }.navigationBarBackButtonHidden(true)
    }
}

//struct Skill_Previews: PreviewProvider {
//    static var previews: some View {
//        Skill()
//    }
//}
