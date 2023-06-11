//
//  EducationModel.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import Foundation

struct EducationModel: Codable, Hashable, Identifiable {
    var id: UUID? = UUID()
    let major: String?
    let institution: String?
    let startDate: String?
    let endDate: String?
    let gpa: String?
    let description: String?
}
