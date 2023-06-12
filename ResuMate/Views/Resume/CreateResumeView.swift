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
                        
                        Button {} label: {
                            ZStack {
                                Image("FirstResume")
                                    .overlay(Color.black.opacity(0.5)) // Add overlay with black color and 50% opacity
                                    .background(Color.lightGray)
                                    .cornerRadius(4)
                                Text("Coming Soon...")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    GridRow {
                        Button {} label: {
                            ZStack {
                                Image("FirstResume")
                                    .overlay(Color.black.opacity(0.5)) // Add overlay with black color and 50% opacity
                                    .background(Color.lightGray)
                                    .cornerRadius(4)
                                Text("Coming Soon...")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Button {} label: {
                            ZStack {
                                Image("FirstResume")
                                    .overlay(Color.black.opacity(0.5)) // Add overlay with black color and 50% opacity
                                    .background(Color.lightGray)
                                    .cornerRadius(4)
                                Text("Coming Soon...")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isPreviewClicked) {
            PreviewResumeView(buttonType: .select, isButtonClicked: $isSelectTemplateClicked, onCloseClicked: {
                isPreviewClicked = false
            })
        }
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
