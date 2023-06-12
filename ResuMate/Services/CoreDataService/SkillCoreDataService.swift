//
//  SkillCoreDataService.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 12/06/23.
//

import Foundation
import CoreData

//MARK: Func to save model to core data
func saveSkillToCoreData(_ skills: [SkillModel], context: NSManagedObjectContext) {
    //setup date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    
    for skill in skills {
        let fetchRequest: NSFetchRequest<Skill> = Skill.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", skill.id?.uuidString ?? "")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let newSkill = Skill(context: context)
                newSkill.id = skill.id
                newSkill.title = skill.title
                
                
                // Save the changes to Core Data
                try context.save()
                print("Successfull to save education to Core Data")
            }else{
                print("Education already exists in Core Data")
            }
        } catch {
            print("Failed to save education to Core Data: \(error)")
        }
    }
}

//MARK: Func to update model in Core Data
func updateSkillInCoreData(_ skill: SkillModel, context: NSManagedObjectContext) {
    let fetchRequest: NSFetchRequest<Skill> = Skill.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", skill.id!.uuidString) // Assuming id is the unique identifier
    
    do {
        let results = try context.fetch(fetchRequest)
        if let existingSkill = results.first {
            // Update the properties
            existingSkill.id = skill.id
            existingSkill.title = skill.title
            
            // Save the changes to Core Data
            do {
                try context.save()
                print("Successfully updated skill in Core Data")
            } catch {
                print("Failed to update skill in Core Data: \(error)")
            }
        } else {
            print("Skill not found in Core Data")
        }
    } catch {
        print("Error fetching education from Core Data: \(error)")
    }
}

//MARK: Func to fetch model from core data
func fetchSkillFromCoreData(context: NSManagedObjectContext) -> [SkillModel] {
    do {
        let fetchRequest: NSFetchRequest<Skill> = Skill.fetchRequest()
        let skills = try context.fetch(fetchRequest)
        
        // Convert Skill objects to SkillModel
        let skillModel = skills.map { skill in
            SkillModel(
                id: skill.id,
                title: skill.title
            )
        }
        
        print("Successfull to fetch skill from Core Data")
        return skillModel
    } catch {
        print("Failed to fetch skill from Core Data: \(error)")
        return []
    }
}
