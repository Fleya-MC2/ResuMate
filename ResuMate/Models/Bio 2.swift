//
//  Bio.swift
//  ResuMate
//
//  Created by Luthfi Asmara on 10/06/23.
//

import SwiftUI

struct Bio: Identifiable, Equatable {
    let id: UUID = UUID()
    var firstname: String?
    var lastname: String?
    var email: String?
    var phone: String?
    var motto: String?
    var summary: String?
}
