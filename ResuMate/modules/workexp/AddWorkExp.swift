//
//  AddWorkExp.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct AddWorkExp: View {
//    @Binding var navigationItemPath: [NavigationItem]

    @State var position: String = ""
    @State var company: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var description: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                BigForm(title: "Position", placeholder: "String", fill: $position)
                BigForm(title: "Company", placeholder: "String", fill: $company)
                HStack{
                    DateForm(title: "Start Date", placeholder: "Date", fill: $startDate)
                    DateForm(title: "End Date", placeholder: "Date", fill: $endDate)
                }
                BigForm(title: "Description", placeholder: "String", fill: $description)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    NavigationLink{
                        WorkExperience()
                    } label:{
                        Image(systemName: "chevron.backward")
                            .frame(height: 17)
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .principal){
                    TitleToolbar(titleToolbar: "Add Work Experience")
                }
            }
        }.navigationBarBackButtonHidden(true)
    }

}

//struct AddWorkExp_Previews: PreviewProvider {
//    static var previews: some View {
//        AddWorkExp()
//    }
//}
