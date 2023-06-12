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
    for workExperience in workExperiences {
        let fetchRequest: NSFetchRequest<WorkExperience> = WorkExperience.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", workExperience.id?.uuidString ?? "")
        print("work experience from resume data id \(workExperience.id!.uuidString)")
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let newWorkExperience = WorkExperience(context: context)
                newWorkExperience.id = workExperience.id
                newWorkExperience.company = workExperience.company
                newWorkExperience.position = workExperience.position
                newWorkExperience.startDate = stringToDate(workExperience.startDate!)
                newWorkExperience.endDate = stringToDate(workExperience.endDate!)
                newWorkExperience.workDescription = workExperience.description
                // Save the changes to Core Data
                try context.save()
                print("Successfull to save work experience to Core Data")
            }else{
                print("Work experience already exists in Core Data")
            }
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
            existingWorkExperience.id = workExperience.id
            existingWorkExperience.company = workExperience.company
            existingWorkExperience.position = workExperience.position
            existingWorkExperience.startDate = stringToDate(workExperience.startDate!)
            existingWorkExperience.endDate = stringToDate(workExperience.endDate!)
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
                id: workExperience.id,
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


