//
//  WorkExperienceModel.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import Foundation

struct WorkExperienceModel: Codable, Hashable {
    let position: String?
    let company: String?
    let startDate: String?
    let endDate: String?
    let description: String?
}
