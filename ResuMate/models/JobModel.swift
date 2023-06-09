//
//  Job.swift
//  JobMate
//
//  Created by Luthfi Asmara on 31/05/23.
//

import SwiftUI

struct JobModel: Identifiable {
    let id: UUID
    let name: String
    let position: String
    let category: String
    let image: String
    let score: Int
    let scoreStatus: ScoreStatusModel
    let endDate: Date
    
    init(id: UUID, name: String, position: String, category: String, image: String, score: Int, scoreStatus: ScoreStatusModel, endDate: Date) {
            self.id = id
            self.name = name
            self.position = position
            self.category = category
            self.image = image
            self.score = score
            self.scoreStatus = scoreStatus
            self.endDate = endDate
        }
}


// Contoh data pekerjaan
let jobLists: [Job] = [
    Job(id: UUID(), name: "Gojek", position: "FrontEnd Dev", category: "Part-Time", image: "tokped", score: 40, scoreStatus: scoreStatuses[0], endDate: Date()),
    Job(id: UUID(), name: "Tokpedia", position: "Backend Dev", category: "Part-Time", image: "tokped", score: 60, scoreStatus: scoreStatuses[1], endDate: Date()),
    Job(id: UUID(), name: "Shopee", position: "iOs Dev", category: "Part-Time", image: "tokped", score: 80, scoreStatus: scoreStatuses[2], endDate: Date()),
    Job(id: UUID(), name: "Gojek", position: "Android Dev", category: "Part-Time", image: "tokped", score: 75, scoreStatus: scoreStatuses[2], endDate: Date()),
    Job(id: UUID(), name: "Gojek", position: "Digital Marketing", category: "Part-Time", image: "tokped", score: 60, scoreStatus: scoreStatuses[1], endDate: Date()),
    Job(id: UUID(), name: "Gojek", position: "Digital Marketing", category: "Part-Time", image: "tokped", score: 60, scoreStatus: scoreStatuses[1], endDate: Date()),
    Job(id: UUID(), name: "Gojek", position: "Digital Marketing", category: "Part-Time", image: "tokped", score: 60, scoreStatus: scoreStatuses[1], endDate: Date()),
    

]
