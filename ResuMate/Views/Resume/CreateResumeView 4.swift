//
//  CreateResumeView.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 10/06/23.
//

import SwiftUI

struct CreateResumeView: View {
    @State var isShowingActionDialog: Bool = false
    @State var isPreviewClicked: Bool = false
    @State var isSelectTemplateClicked: Bool = false
    
    var body: some View {
        VStack {
            CustomToolbar2(titleToolbar: "Create Resume", destination: HomeView(selection: 0))
            
            ScrollView {
                VStack{
                    //                    Title(title: "Create Resume")
                    
                    Subtitle(subtitle: "Select one template that most describe yourself.")
                }.frame(width: 300)
                
                Spacer().frame(height: 55)
                
                Grid {
                    GridRow {
                        Button {
                            isShowingActionDialog = true
                        } label: {
                            Image("FirstResume")
                        }
                        
                        Button {
                            isShowingActionDialog = true
                        } label: {
                            Image("SecondResume")
                        }
                    }
                    
                    GridRow {
                        Button {
                            isShowingActionDialog = true
                        } label: {
                            Image("ThirdResume")
                        }
                        
                        Spacer()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isPreviewClicked, destination: {
            HomeView()
        })
        .navigationDestination(isPresented: $isSelectTemplateClicked, destination: {
            SelectResumeDataView()
        })
        .confirmationDialog("Select action", isPresented: $isShowingActionDialog, titleVisibility: .hidden) {
            Button("Preview") {
                isPreviewClicked = true
            }
            
            Button("Select Template") {
                isSelectTemplateClicked = true
            }
        }
    }
}

struct CreateResumeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateResumeView()
    }
}
