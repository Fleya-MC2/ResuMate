//
//  AchievementModel.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import Foundation

struct VolunteerModel: Codable, Hashable {
    let role: String
    let place: String
    let startDate: String
    var endDate: String = ""
    var description: String = ""
}
