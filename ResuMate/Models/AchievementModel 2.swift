//
//  AchievementModel.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import Foundation

struct AchievementModel: Codable, Hashable, Identifiable {
    var id: UUID? = UUID()
    let title: String?
    let year: String?
    var description: String?
}
