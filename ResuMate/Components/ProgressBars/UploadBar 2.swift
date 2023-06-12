//
//  UploadBar.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 11/06/23.
//

import SwiftUI

enum UploadStatus {
    case loading
    case finished
}

struct UploadBar: View {
    var progress: CGFloat
    var uploadStatus: UploadStatus
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.5))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    Rectangle()
                        .foregroundColor(uploadStatus == .loading ? .blue : .lightGreen)
                        .frame(width: geometry.size.width * progress, height: geometry.size.height)
                }
                .cornerRadius(geometry.size.height / 2)
            }.frame(width: 340, height: 5)
            
            HStack{
                Spacer()
                
                switch uploadStatus {
                case .loading:
                    Text("Processing your data. . . ")
                        .blacktext15()
                case .finished:
                    Text("Finished!")
                        .lightGreen15()
                }
                

                    
            }.padding(.horizontal, 25)
        }
    }
}

struct UploadBar_Previews: PreviewProvider {
    static var previews: some View {
        UploadBar(progress: 0.2, uploadStatus: .loading)
    }
}
