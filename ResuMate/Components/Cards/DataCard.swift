//
//  CardList.swift
//  JobMate
//
//  Created by Luthfi Asmara on 08/06/23.
//

import SwiftUI

enum DataImage : String {
    case personalData = "person.fill"
    case workExperience = "suitcase.fill"
    case education = "graduationcap.fill"
    case organization = "person.3.fill"
    case skill = "crown.fill"
    case achievement = "trophy.fill"
    case volunteering = "figure.2.arms.open"
}

struct DataCard: View {
    @State var label: String
    @State var img: DataImage
    @State var isFilled: Bool
    var body: some View {
        ZStack{
            HStack{
                Text(label)
                    .white17()
                    .bold()
                    
                Spacer()
                
                Image(systemName: img.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: getImageWidth(image: img))
                    .foregroundColor(.white)
                    .rotationEffect(Angle(degrees: -10.63))
                
                if isFilled{
                    Spacer().frame(width: 18)
                }
            }
            .padding(.leading, 15)
            .padding(.trailing, 25)
            .frame(width: 325, height: 70)
            .background(isFilled ? .blue : .gray.opacity(0.5))
            .cornerRadius(14)
            .padding(.bottom, 10)
            if isFilled{
                
                HStack{
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.lightGreen)
                            .background(Circle().fill(.white))
                }.offset(x:-20, y: -30)
            }
        }
    }
    
    func getImageWidth(image: DataImage) -> CGFloat {
        switch image {
        case .personalData:
            return 54
        case .workExperience:
            return 72
        case .education:
            return 80
        case .organization:
            return 106
        case .skill:
            return 78
        case .achievement:
            return 63
        case .volunteering:
            return 75
        }
    }
}

struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        DataCard(label: "Personal Data", img: .organization, isFilled: false)
    }
}
