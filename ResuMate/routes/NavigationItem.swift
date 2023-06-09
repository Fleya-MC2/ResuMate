//
//  NavigationItem.swift
//  JobMate
//
//  Created by Luthfi Asmara on 09/06/23.
//

import SwiftUI

struct NavigationItem: Identifiable, Hashable {
    var id = UUID()
    var label: String
    var img: String
    var isFilled: Bool
    var menu: Menu
}
