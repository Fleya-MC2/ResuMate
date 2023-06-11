//
//  AchievementCoreDataService.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 10/06/23.
//

import Foundation
import CoreData

//MARK: Func to save model to core data
func saveAchivementToCoreData(_ achievements: [AchievementModel], context: NSManagedObjectContext) {
    //setup date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    
    for achievement in achievements {
        let newAchievement = Achievement(context: context)
        newAchievement.title = achievement.title
        newAchievement.year = dateFormatter.date(from: achievement.year!)
        newAchievement.achivementDescription = achievement.description
        
        // Save the changes to Core Data
        do {
            try context.save()
            print("Successfull to save education to Core Data")
        } catch {
            print("Failed to save education to Core Data: \(error)")
        }
    }
}

//MARK: Func to update model in Core Data
func updateAchievementInCoreData(_ achievement: AchievementModel, context: NSManagedObjectContext) {
    let fetchRequest: NSFetchRequest<Achievement> = Achievement.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", achievement.id!.uuidString) // Assuming id is the unique identifier
    
    //setup date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    
    do {
        let results = try context.fetch(fetchRequest)
        if let existingAchievement = results.first {
            // Update the properties
            existingAchievement.year = dateFormatter.date(from: achievement.year!)
            existingAchievement.achivementDescription = achievement.description
            
            // Save the changes to Core Data
            do {
                try context.save()
                print("Successfully updated achievement in Core Data")
            } catch {
                print("Failed to update achievement in Core Data: \(error)")
            }
        } else {
            print("Achievement not found in Core Data")
        }
    } catch {
        print("Error fetching achievement from Core Data: \(error)")
    }
}

//MARK: Func to fetch model from core data
func fetchAchivementFromCoreData(context: NSManagedObjectContext) -> [AchievementModel] {
    do {
        let fetchRequest: NSFetchRequest<Achievement> = Achievement.fetchRequest()
        let achievements = try context.fetch(fetchRequest)
        
        // Convert Education objects to EducationModel
        let achievementModels = achievements.map { achievement in
            AchievementModel(
                id: UUID(),
                title: achievement.title,
                year: achievement.year?.toString(),
                description: achievement.achivementDescription
            )
        }
        
        print("Successfull to fetch education from Core Data")
        return achievementModels
    } catch {
        print("Failed to fetch education from Core Data: \(error)")
        return []
    }
}
