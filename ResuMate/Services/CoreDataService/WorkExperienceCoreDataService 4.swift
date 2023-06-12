//
//  WorkExperienceCoreDataService.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 10/06/23.
//

import Foundation
import CoreData

//MARK: Func to save model to core data
func saveWorkExperienceToCoreData(_ workExperiences: [WorkExperienceModel], context: NSManagedObjectContext) {
    //setup date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyyy"
    
    for workExperience in workExperiences {
        let newWorkExperience = WorkExperience(context: context)
        newWorkExperience.company = workExperience.company
        newWorkExperience.position = workExperience.position
        newWorkExperience.startDate = dateFormatter.date(from: workExperience.startDate!)
        newWorkExperience.endDate = dateFormatter.date(from: workExperience.endDate!)
        newWorkExperience.workDescription = workExperience.description
        
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
func updateWorkExperienceInCoreData(_ workExperience: WorkExperienceModel, context: NSManagedObjectContext) {
    let fetchRequest: NSFetchRequest<WorkExperience> = WorkExperience.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", workExperience.id!.uuidString) // Assuming company is the unique identifier
    
    //setup date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyyy"
    
    do {
        let results = try context.fetch(fetchRequest)
        if let existingWorkExperience = results.first {
            // Update the properties
            existingWorkExperience.company = workExperience.company
            existingWorkExperience.position = workExperience.position
            existingWorkExperience.startDate = dateFormatter.date(from: workExperience.startDate!)
            existingWorkExperience.endDate = dateFormatter.date(from: workExperience.endDate!)
            existingWorkExperience.workDescription = workExperience.description
            
            // Save the changes to Core Data
            do {
                try context.save()
                print("Successfully updated work experience in Core Data")
            } catch {
                print("Failed to update work experience in Core Data: \(error)")
            }
        } else {
            print("Work experience not found in Core Data")
        }
    } catch {
        print("Error fetching work experience from Core Data: \(error)")
    }
}

//MARK: Func to fetch model from core data
func fetchWorkExperienceFromCoreData(context: NSManagedObjectContext) -> [WorkExperienceModel] {
    do {
        let fetchRequest: NSFetchRequest<WorkExperience> = WorkExperience.fetchRequest()
        let workExperiences = try context.fetch(fetchRequest)
        
        // Convert Education objects to EducationModel
        let workExperienceModels = workExperiences.map { workExperience in
            WorkExperienceModel(
                id: UUID(),
                position: workExperience.position,
                company: workExperience.company,
                startDate: workExperience.startDate?.toString(),
                endDate: workExperience.endDate?.toString(),
                description: workExperience.workDescription
            )
        }
        
        print("Successfull to fetch education from Core Data")
        return workExperienceModels
    } catch {
        print("Failed to fetch education from Core Data: \(error)")
        return []
    }
}


