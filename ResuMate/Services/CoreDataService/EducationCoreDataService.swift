//
//  EducationCoreDataService.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 10/06/23.
//

import Foundation
import CoreData

//MARK: Func to save model to core data
func saveEducationToCoreData(_ educations: [EducationModel], context: NSManagedObjectContext) {
    //setup date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    
    for education in educations {
        let fetchRequest: NSFetchRequest<Education> = Education.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", education.id?.uuidString ?? "")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let newEducation = Education(context: context)
                newEducation.id = education.id
                newEducation.major = education.major
                newEducation.institution = education.institution
                newEducation.startDate = dateFormatter.date(from: education.startDate!)
                newEducation.endDate = dateFormatter.date(from: education.endDate!)
                newEducation.gpa = Double(education.gpa ?? "0") ?? 0
                newEducation.educationDescription = education.description
                
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
func updateEducationInCoreData(_ education: EducationModel, context: NSManagedObjectContext) {
    let fetchRequest: NSFetchRequest<Education> = Education.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", education.id!.uuidString) // Assuming id is the unique identifier
    print("this is update education id \(education.id!.uuidString)")
    do {
        let results = try context.fetch(fetchRequest)
        if let existingEducation = results.first {
            // Update the properties
            existingEducation.id = education.id
            existingEducation.major = education.major
            existingEducation.institution = education.institution
            existingEducation.startDate = stringToDate(education.startDate!)
            existingEducation.endDate = stringToDate(education.endDate!)
            existingEducation.gpa = Double(education.gpa ?? "0") ?? 0
            existingEducation.educationDescription = education.description

            // Save the changes to Core Data
            do {
                try context.save()
                print("Successfully updated education in Core Data")
            } catch {
                print("Failed to update education in Core Data: \(error)")
            }
        } else {
            print("Education not found in Core Data")
        }
    } catch {
        print("Error fetching education from Core Data: \(error)")
    }
}

//MARK: Func to fetch model from core data
func fetchEducationFromCoreData(context: NSManagedObjectContext) -> [EducationModel] {
    do {
        let fetchRequest: NSFetchRequest<Education> = Education.fetchRequest()
        let educations = try context.fetch(fetchRequest)
        
        // Convert Education objects to EducationModel
        let educationModels = educations.map { education in
            EducationModel(
                id: education.id,
                major: education.major,
                institution: education.institution,
                startDate: education.startDate?.toString(),
                endDate: education.endDate?.toString(),
                gpa: String(education.gpa),
                description: education.educationDescription
            )
        }
        
        print("Successfull to fetch education from Core Data")
        return educationModels
    } catch {
        print("Failed to fetch education from Core Data: \(error)")
        return []
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
