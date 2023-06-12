//
//  SuggestionModel.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 08/06/23.
//

import Foundation

struct SuggestionModel: Codable, Hashable, Identifiable {
    let id = UUID() // Each instance will now have a unique id
    let suggestion: String
}

