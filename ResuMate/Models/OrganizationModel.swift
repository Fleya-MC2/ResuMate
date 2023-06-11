//
//  OrganizationModel.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import Foundation

struct OrganizationModel: Codable, Hashable, Identifiable {
    var id: UUID? = UUID()
    let role: String?
    let organization: String?
    let startDate: String?
    let endDate: String?
    let description: String?
}
