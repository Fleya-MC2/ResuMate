//
//  EmptyPage.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

struct ResumeView: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                NavigationLink{
                    CreateResumeView()
                }label: {
                    HStack{
                        Text("Create resume")
                            .strongblue20()
                            .fontWeight(.semibold)
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.darkBlue)
                    }
                    .padding(.trailing, 20)
                    
                }
            }
            
            Spacer().frame(height: 65)
            
            VStack(alignment: .leading){
                Title(title: "Resume")
                
                Text("Seems you haven’t created a resume before.")
                    .blacktext20()
                    .fontWeight(.medium)
                
                Text("Don't worry! Just start creating your resume now!")
                    .blacktext17()
                    .fontWeight(.thin)
            }.padding(.horizontal,35)
            Spacer().frame(height: 65)
            HStack{
                NavigationLink{
                    CreateResumeView()
                }label: {
                    VStack{
                        Image(systemName: "plus")
                            .font(.system(size: 50, weight: .semibold))
                            .foregroundColor(.darkBlue)
                            .frame(width: 156, height: 213)
                            .background(Color.mediumGray)
                        Text("Create Resume")
                            .strongblue17()
                            .fontWeight(.light)
                    }
                }

                Spacer()
            }.padding(.horizontal,35)
            
            Spacer()
        }
    }
}

struct ResumeView_Previews: PreviewProvider {
    static var previews: some View {
        ResumeView()
    }
}
