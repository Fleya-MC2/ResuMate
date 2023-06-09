//
//  Organization.swift
//  ResuMate
//
//  Created by Luthfi Asmara on 10/06/23.
//

import SwiftUI

struct OrganizationView: View {
    @EnvironmentObject var cardLists: CardLists
    @EnvironmentObject var viewModel: ResumeViewModel
    @Environment(\.managedObjectContext) private var moc
    
    @State var isButtonActive: Bool = false
    @State var isSubmit: Bool = false

    var body: some View {
                VStack{
                    CustomToolbar(titleToolbar: "Organization Experience", destinationL: HomeView(selection: 1), destinationT: AddOrganization(inputType: .add))
                    Spacer().frame(height: 17)
                    Text("Borem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.")
                        .blacktext17()
                        .fontWeight(.light)
                        .padding(.horizontal, 20)
                    Spacer().frame(height: 40)
                    
                    ForEach(viewModel.organization){ itm in
                        NavigationLink {
                            AddOrganization(inputType: .edit, selectedOrganization: itm)
                        } label: {
                            HStack{
                                Text("\(itm.role ?? "") - \(itm.organization ?? "")")
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
                    if viewModel.organization.count == 0 {
                        NavigationLink{
                            AddOrganization(inputType: .add)
                        }label:{
                            HStack{
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.darkBlue)
                                Text("Add Organization")
                                    .strongblue15()
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    Spacer()
                        BigButton(text: "Submit", isButtonactive: isButtonActive) {
                            if isButtonActive{
                                cardLists.isOrganizationFilled = true
                                isSubmit = true
                                //call to save in core data
                                saveOrganizationToCoreData(viewModel.organization, context: moc)
                            }
                        }
                    
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onReceive(viewModel.$organization) { newOrganization in
                        if newOrganization.count != 0 {
                            isButtonActive = true
                        }
                        print(isButtonActive)
                    }
                    .navigationDestination(isPresented: $isSubmit, destination: {
                        HomeView(selection: 1)
                    })
            .navigationBarBackButtonHidden(true)
            .onAppear{
                if viewModel.organization == []{
                    viewModel.organization = fetchOrganizationFromCoreData(context: moc)
                }
            }
        
    }
    
        
        
}

