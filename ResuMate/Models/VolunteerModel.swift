//
//  AchievementModel.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import Foundation

struct VolunteerModel: Codable, Hashable {
    var role: String?
    var place: String?
    var startDate: Date?
    var endDate: Date?
    var description: String?
}
