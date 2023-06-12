//
//  WorkExperience.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct WorkExperienceView: View {
    @EnvironmentObject var cardLists: CardLists
    @EnvironmentObject var viewModel: ResumeViewModel
    @Environment(\.managedObjectContext) private var moc
    
    @State var isButtonactive: Bool = false
    @State var isSubmit: Bool = false
    
    var body: some View {
        VStack{
            CustomToolbar(titleToolbar: "Work Experience", destinationL: HomeView(selection: 1), destinationT: AddWorkExperienceView(inputType: .add))
            Spacer().frame(height: 17)
            Text("Present your most recent and applicable experience, showcasing your relevant work history, including any internships, scholarships, relevant coursework, and academic achievements.")
                .blacktext17()
                .fontWeight(.regular)
            Spacer().frame(height: 40)
            ForEach(viewModel.workExperience){ item in
                NavigationLink {
                    AddWorkExperienceView(inputType: .edit, selectedWorkExperience: item)
                } label: {
                    HStack{
                        Text("\(item.position ?? "") - \(item.company ?? "")")
                            .blacktext15()
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }.padding(.horizontal, 20)
                        .frame(width: 338, height: 55)
                        .cornerRadius(9)
                        .overlay(RoundedRectangle(cornerRadius: 9).stroke(.gray, lineWidth: 1))
                }
                
            }
            if viewModel.workExperience.count == 0 {
                NavigationLink{
                    AddWorkExperienceView(inputType: .add)
                }label: {
                    HStack{
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.darkBlue)
                        Text("Add Work Experience")
                            .strongblue15()
                            .fontWeight(.semibold)
                    }
                }
            }
            
            Spacer()
            
            BigButton(text: "Submit", isButtonactive: isButtonactive) {
                if isButtonactive{
                    cardLists.isWorkExpFilled = true
                    isSubmit = true
                    //call to save data
                    saveWorkExperienceToCoreData(viewModel.workExperience, context: moc)
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onReceive(viewModel.$workExperience) { newWorkExp in
                if newWorkExp.count != 0 {
                    isButtonactive = true
                }
                print(isButtonactive)
            }
            .navigationDestination(isPresented: $isSubmit, destination: {
                HomeView(selection: 1)
            })
            .navigationBarBackButtonHidden(true)
            .onAppear{
                if viewModel.workExperience == []{
                    viewModel.workExperience = fetchWorkExperienceFromCoreData(context: moc)
                }
            }
    }
}

//struct WorkExperience_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkExperience()
//    }
//}
