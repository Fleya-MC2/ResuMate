//
//  Skill.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct Skill: View {

    var body: some View {
        VStack{
           
            CustomToolbar2(titleToolbar: "Skill", destination: DataView())
            Spacer().frame(height: 27)
            InputTag()
        }.navigationBarBackButtonHidden(true)
    }
}

//struct Skill_Previews: PreviewProvider {
//    static var previews: some View {
//        Skill()
//    }
//}
