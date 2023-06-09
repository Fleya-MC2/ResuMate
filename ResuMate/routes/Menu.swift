//
//  Menu.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

enum Menu: String {
    case personaldata
    case workexp
    case addworkexp
    case education
    case organization
    case achievement
    case skill
   
}

var navigationItems = [
    NavigationItem(label: "Personal Data", img: "personal-data", isFilled: false, menu: .personaldata),
    NavigationItem(label: "Work Experience", img: "work-exp", isFilled: false, menu: .workexp),
    NavigationItem(label: "Education Background", img: "education", isFilled: false, menu: .education),
    NavigationItem(label: "Organixation Experience", img: "organization", isFilled: false, menu: .organization),
    NavigationItem(label: "Achievement", img: "achievement", isFilled: false, menu: .achievement),
    NavigationItem(label: "Skill", img: "skill", isFilled: false, menu: .skill),
    
]
