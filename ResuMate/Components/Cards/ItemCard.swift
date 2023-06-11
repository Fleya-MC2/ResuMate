//
//  ResumeCard.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 10/06/23.
//

import SwiftUI

struct ItemCard: View {
    var text: String
    
    var isShowingThumbsUp: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Text(text)
                    .darkGray17()
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(.white)
                    .cornerRadius(8)
                
                if isShowingThumbsUp {
                        HStack {
                            Spacer()
                            
                            Image(systemName: "hand.thumbsup.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .frame(width: 30, height: 30)
                                .background(Color.lightYellow)
                                .clipShape(Circle())
                        }
                        .padding(.bottom, 64)

                }
            }
        }
    }
}

struct ResumeCard_Previews: PreviewProvider {
    static var previews: some View {
        ItemCard(text: "Management - UPN ‘Veteran’ Yogyakarta dqwdeqw", isShowingThumbsUp: true)
    }
}
