//
//  VolunteerCoreDataService.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 10/06/23.
//

import Foundation
import CoreData

//MARK: Func to save model to core data
func saveVolunteerToCoreData(_ volunteers: [VolunteerModel], context: NSManagedObjectContext) {
    //setup date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    
    for volunteer in volunteers {
        let fetchRequest: NSFetchRequest<Volunteer> = Volunteer.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", volunteer.id?.uuidString ?? "")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let newVolunteer = Volunteer(context: context)
                newVolunteer.id = volunteer.id
                newVolunteer.role = volunteer.role
                newVolunteer.place = volunteer.place
                newVolunteer.startDate = dateFormatter.date(from: volunteer.startDate!)
                newVolunteer.endDate = dateFormatter.date(from: volunteer.endDate!)
                newVolunteer.volunteerDescription = volunteer.description
                
                // Save the changes to Core Data
                try context.save()
                print("Successfull to save volunteer to Core Data")
            }else{
                print("Volunteer already exists in Core Data")
            }
        } catch {
            print("Failed to save education to Core Data: \(error)")
        }
    }
}

//MARK: Func to update model in Core Data
func updateVolunteerInCoreData(_ volunteer: VolunteerModel, context: NSManagedObjectContext) {
    let fetchRequest: NSFetchRequest<Volunteer> = Volunteer.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", volunteer.id!.uuidString) // Assuming id is the unique identifier
    
    //setup date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    
    do {
        let results = try context.fetch(fetchRequest)
        if let existingVolunteer = results.first {
            // Update the properties
            existingVolunteer.id = volunteer.id
            existingVolunteer.role = volunteer.role
            existingVolunteer.place = volunteer.place
            existingVolunteer.startDate = dateFormatter.date(from: volunteer.startDate!)
            existingVolunteer.endDate = dateFormatter.date(from: volunteer.endDate!)
            existingVolunteer.volunteerDescription = volunteer.description
            
            // Save the changes to Core Data
            do {
                try context.save()
                print("Successfully updated volunteer in Core Data")
            } catch {
                print("Failed to update volunteer in Core Data: \(error)")
            }
        } else {
            print("Volunteer not found in Core Data")
        }
    } catch {
        print("Error fetching volunteer from Core Data: \(error)")
    }
}

//MARK: Func to fetch model from core data
func fetchVolunteerFromCoreData(context: NSManagedObjectContext) -> [VolunteerModel] {
    do {
        let fetchRequest: NSFetchRequest<Volunteer> = Volunteer.fetchRequest()
        let volunteers = try context.fetch(fetchRequest)
        
        // Convert Education objects to EducationModel
        let volunteerModels = volunteers.map { volunteer in
            VolunteerModel(
                id: volunteer.id,
                role: volunteer.role,
                place: volunteer.place,
                startDate: volunteer.startDate?.toString(),
                endDate: volunteer.startDate?.toString(),
                description: volunteer.volunteerDescription
            )
        }
        
        print("Successfull to fetch education from Core Data")
        return volunteerModels
    } catch {
        print("Failed to fetch education from Core Data: \(error)")
        return []
    }
}
