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
        self.font(.system(size: 20)).foregroundColor(.darkblue)
    }
    func strongblue17() -> some View{
        self.font(.system(size: 17)).foregroundColor(.darkblue)
    }
    func strongblue15() -> some View{
        self.font(.system(size: 15)).foregroundColor(.darkblue)
    }
    
    func white17() -> some View{
        self.font(.system(size: 17)).foregroundColor(.white)
    }
    func white15() -> some View{
        self.font(.system(size: 15)).foregroundColor(.white)
    }
    
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

extension Color {
    static let navy = Color("Navy")
    static let light = Color("light")
    static let lightBlue = Color("LightBlue")
    static let darkblue = Color("DarkBlue")
    static let lightGray = Color("LightGray")
    static let darkGray = Color("DarkGray")
    static let greencheck = Color("GreenCheck")
    static let modal = Color("Modal")
}
