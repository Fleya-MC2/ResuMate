//
//  ScoreStatus.swift
//  JobMate
//
//  Created by Luthfi Asmara on 31/05/23.
//

import SwiftUI

struct ScoreStatusModel: Identifiable {
    let id: UUID
    let color: Color
    
    init(id: UUID, color: Color) {
            self.id = id
            self.color = color
        }
}

// Contoh data status skor
let scoreStatuses: [ScoreStatusModel] = [
    ScoreStatusModel(id: UUID(), color: .red),
    ScoreStatusModel(id: UUID(), color: .orange),
    ScoreStatusModel(id: UUID(), color: .green)
]
