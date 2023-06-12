//
//  WorkExp.swift
//  ResuMate
//
//  Created by Luthfi Asmara on 10/06/23.
//

import SwiftUI

struct WorkExp: Identifiable, Equatable {
    let id: UUID
    var position: String
    var company: String
    var startDate: Date
    var endDate: Date
    var description: String
    
    
}
