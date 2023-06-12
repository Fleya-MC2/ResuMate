//
//  WorkExperienceModel.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import Foundation

struct WorkExperienceModel: Codable, Hashable, Identifiable {
    var id: UUID?
    var position: String?
    var company: String?
    var startDate: String?
    var endDate: String?
    var description: String?
}
