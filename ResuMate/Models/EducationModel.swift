//
//  EducationModel.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import Foundation

struct EducationModel: Codable, Hashable, Identifiable {
    var id: UUID?
    var major: String?
    var institution: String?
    var startDate: String?
    var endDate: String?
    var gpa: String?
    var description: String?
}
