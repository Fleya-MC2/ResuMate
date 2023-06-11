//
//  Extensions.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 10/06/23.
//

import Foundation
import SwiftUI

extension View {
    func blacktext17() -> some View{
        self.font(.system(size: 17)).foregroundColor(.black)
    }
    func blacktext15() -> some View{
        self.font(.system(size: 15)).foregroundColor(.black)
    }
    func blacktext20() -> some View{
        self.font(.system(size: 20)).foregroundColor(.black)
    }
    
    
    func strongblue20() -> some View{
        self.font(.system(size: 20)).foregroundColor(.darkBlue)
    }
    func strongblue17() -> some View{
        self.font(.system(size: 17)).foregroundColor(.darkBlue)
    }
    func strongblue15() -> some View{
        self.font(.system(size: 15)).foregroundColor(.darkBlue)
    }
    
    func white17() -> some View{
        self.font(.system(size: 17)).foregroundColor(.white)
    }
    func white15() -> some View{
        self.font(.system(size: 15)).foregroundColor(.white)
    }
    
    func darkGray17() -> some View {
        self.font(.system(size: 17)).foregroundColor(.darkGray)
    }
    
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

extension Color {
    static let navy = Color("Navy")
    static let light = Color("light")
    static let lightBlue = Color("LightBlue")
    static let darkBlue = Color("DarkBlue")
    static let lightGray = Color("LightGray")
    static let mediumGray = Color("MediumGray")
    static let mediumDarkGray = Color("MediumDarkGray")
    static let darkGray = Color("DarkGray")
    static let lightGreen = Color("LightGreen")
    static let lightYellow = Color("LightYellow")
    static let modal = Color("Modal")
}
