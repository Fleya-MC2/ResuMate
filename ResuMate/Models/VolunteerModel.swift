//
//  AchievementModel.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import Foundation

struct VolunteerModel: Codable, Hashable, Identifiable {
    var id: UUID? = UUID()
    var role: String?
    var place: String?
    var startDate: String?
    var endDate: String?
    var description: String?
}
