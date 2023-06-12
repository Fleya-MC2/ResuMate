//
//  OrganizationModel.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import Foundation

struct OrganizationModel: Codable, Hashable, Identifiable {
    var id: UUID?
    var role: String?
    var organization: String?
    var startDate: String?
    var endDate: String?
    var description: String?
}
