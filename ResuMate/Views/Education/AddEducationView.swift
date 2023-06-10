//
//  AddEducation.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct AddEducationView: View {
//    @Binding var navigationItemPath: [NavigationItem]
    @EnvironmentObject var cardLists: CardLists
    @State var major: String = ""
    @State var institution: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var score: String = ""
    @State var description: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                CustomToolbar2(titleToolbar: "Add Education", destination: EducationView())
//                BigForm(title: "Major", placeholder: "String", fill: $major)
//                BigForm(title: "Institution", placeholder: "String", fill: $institution)
//                HStack{
//                    DateForm(title: "Start Date", placeholder: "Date", fill: $startDate)
//                    DateForm(title: "End Date", placeholder: "Date", fill: $endDate)
//                }
//                BigForm(title: "GPA/Score", placeholder: "String", fill: $score)
//                BigForm(title: "Description", placeholder: "String", fill: $description)
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

//struct AddEducation_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEducation()
//    }
//}
