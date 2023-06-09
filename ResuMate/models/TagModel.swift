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
        Tag(name: "Swift"),
        Tag(name: "iOS"),
        Tag(name: "Xcode"),
        Tag(name: "UI"),
        Tag(name: "UX"),
        Tag(name: "CoreData"),
        Tag(name: "Networking"),
        Tag(name: "Firebase"),
        Tag(name: "SwiftUI"),
    ]
