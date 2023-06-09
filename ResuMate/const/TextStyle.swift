//
//  TextStyle.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

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
        self.font(.system(size: 20)).foregroundColor(.strongblue)
    }
    func strongblue17() -> some View{
        self.font(.system(size: 17)).foregroundColor(.strongblue)
    }
    func strongblue15() -> some View{
        self.font(.system(size: 15)).foregroundColor(.strongblue)
    }
    
    func white17() -> some View{
        self.font(.system(size: 17)).foregroundColor(.white)
    }
    func white15() -> some View{
        self.font(.system(size: 15)).foregroundColor(.white)
    }
    
}

