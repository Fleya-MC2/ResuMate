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
    for education in educations {
        let newEducation = Education(context: context)
        newEducation.major = education.major
        newEducation.institution = education.institution
        newEducation.startDate = education.startDate
        newEducation.endDate = education.endDate
        newEducation.gpa = Double(education.gpa!) ?? 0
        newEducation.educationDescription = education.description
        
        // Save the changes to Core Data
        do {
            try context.save()
        } catch {
            print("Failed to save education to Core Data: \(error)")
        }
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
                major: education.major,
                institution: education.institution,
                startDate: education.startDate,
                endDate: education.endDate,
                gpa: String(education.gpa),
                description: education.educationDescription
            )
        }
        
        return educationModels
    } catch {
        print("Failed to fetch education from Core Data: \(error)")
        return []
    }
}
