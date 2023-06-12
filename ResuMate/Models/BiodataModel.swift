//
//  Biodata.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 08/06/23.
//

import Foundation

struct BiodataModel: Codable, Identifiable {
    var id: UUID? = UUID()
    let firstName: String?
    let lastName: String?
    let phoneNumber: String?
    let email: String?
    let professionalMotto: String?
    let professionalSummary: String?
}
