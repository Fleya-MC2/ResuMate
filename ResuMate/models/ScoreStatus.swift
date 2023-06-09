//
//  ScoreStatus.swift
//  JobMate
//
//  Created by Luthfi Asmara on 31/05/23.
//

import SwiftUI

struct ScoreStatus: Identifiable {
    let id: UUID
    let color: Color
    
    init(id: UUID, color: Color) {
            self.id = id
            self.color = color
        }
}

// Contoh data status skor
let scoreStatuses: [ScoreStatus] = [
    ScoreStatus(id: UUID(), color: .red),
    ScoreStatus(id: UUID(), color: .orange),
    ScoreStatus(id: UUID(), color: .green)
]
