//
//  Tag.swift
//  JobMate
//
//  Created by Luthfi Asmara on 05/06/23.
//

import SwiftUI

struct TagModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var width: CGFloat? = nil
}

let tagLists = [
    TagModel(name: "Swift"),
    TagModel(name: "iOS"),
    TagModel(name: "Xcode"),
    TagModel(name: "UI"),
    TagModel(name: "UX"),
    TagModel(name: "CoreData"),
    TagModel(name: "Networking"),
    TagModel(name: "Firebase"),
    TagModel(name: "SwiftUI"),
    ]
