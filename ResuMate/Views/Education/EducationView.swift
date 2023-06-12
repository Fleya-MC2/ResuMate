//
//  EducationalBackground.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct EducationView: View {
    
    @EnvironmentObject var cardLists: CardLists
    @EnvironmentObject var viewModel: ResumeViewModel
    @Environment(\.managedObjectContext) private var moc
    
    @State var isButtonActive: Bool = false
    @State var isSubmit: Bool = false
    
    var body: some View {
        VStack{
            CustomToolbar(titleToolbar: "Educational Background", destinationL: HomeView(selection: 1), destinationT: AddEducationView(inputType: .add))
            Spacer().frame(height: 17)
            Text("Borem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.")
                .blacktext17()
                .fontWeight(.light)
                .padding(.horizontal, 20)
            Spacer().frame(height: 40)
            
            ForEach(viewModel.education){ itm in
                NavigationLink {
                    AddEducationView(inputType: .edit, selectedEducation: itm)
                } label: {
                    HStack{
                        Text("\(itm.major ?? "") - \(itm.institution ?? "")")
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
            if viewModel.education.count == 0 {
                NavigationLink{
                    AddEducationView(inputType: .add)
                }label:{
                    HStack{
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.darkBlue)
                        Text("Add Education")
                            .strongblue15()
                            .fontWeight(.semibold)
                    }
                }
            }
            Spacer()
            BigButton(text: "Submit", isButtonactive: isButtonActive) {
                if isButtonActive{
                    cardLists.isEducationFilled = true
                    isSubmit = true
                    //call to save data
                    saveEducationToCoreData(viewModel.education, context: moc)
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onReceive(viewModel.$education) { newEducation in
                if newEducation.count != 0 {
                    isButtonActive = true
                }
                
                print(isButtonActive)
            }
            .navigationDestination(isPresented: $isSubmit, destination: {
                HomeView(selection: 1)
            })
            .navigationBarBackButtonHidden(true)
            .onAppear{
                if viewModel.education == []{
                    viewModel.education = fetchEducationFromCoreData(context: moc)
                }
            }
    }
    
}

//struct EducationalBackground_Previews: PreviewProvider {
//    static var previews: some View {
//        EducationalBackground()
//    }
//}
