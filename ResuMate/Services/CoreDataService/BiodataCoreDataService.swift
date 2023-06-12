//
//  BiodataCoreDataService.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 10/06/23.
//

import Foundation
import CoreData

//MARK: Func to save model to core data
func saveBiodataToCoreData(_ biodata: BiodataModel, context: NSManagedObjectContext) {
    
    let newBiodata = Person(context: context)
    newBiodata.firstName = biodata.firstName
    newBiodata.lastName = biodata.lastName
    newBiodata.email = biodata.email
    newBiodata.phoneNumber = biodata.phoneNumber
    newBiodata.professionalMotto = biodata.professionalMotto
    newBiodata.professionalSummary = biodata.professionalSummary
    // Save the changes to Core Data
    do {
        try context.save()
        print("Successfull to save biodata to Core Data")
    } catch {
        print("Failed to save biodata to Core Data: \(error)")
    }
}

//MARK: Func to update model in Core Data by ID
func updateBiodataInCoreData(_ biodata: BiodataModel, context: NSManagedObjectContext) {
    let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
//    fetchRequest.predicate = NSPredicate(format: "id == %@", biodata.id?.uuidString ?? "") // Assuming "firstname" is the unique identifier
    
    do {
        let results = try context.fetch(fetchRequest)
        if let existingBiodata = results.first {
            // Update the properties
            existingBiodata.firstName = biodata.firstName
            existingBiodata.lastName = biodata.lastName
            existingBiodata.email = biodata.email
            existingBiodata.phoneNumber = biodata.phoneNumber
            existingBiodata.professionalMotto = biodata.professionalMotto
            existingBiodata.professionalSummary = biodata.professionalSummary
            
            // Save the changes to Core Data
            do {
                try context.save()
                print("Successfully updated biodata in Core Data")
            } catch {
                print("Failed to update biodata in Core Data: \(error)")
            }
        } else {
            print("Biodata not found in Core Data")
            // If biodata does not exist, create a new entry
            saveBiodataToCoreData(biodata, context: context)
        }
    } catch {
        print("Error fetching biodata from Core Data: \(error)")
    }
}

//MARK: Func to fetch model from core data
func fetchBiodataFromCoreData(context: NSManagedObjectContext) -> BiodataModel {
    do {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        let persons = try context.fetch(fetchRequest)
        let person = persons.first
        
        print(person?.firstName ?? "no firstname data")
        // Convert Education objects to EducationModel
        let biodataModel = BiodataModel(
            firstName: person?.firstName, lastName: person?.lastName, phoneNumber: person?.phoneNumber, email: person?.email, professionalMotto: person?.professionalMotto, professionalSummary: person?.professionalSummary
        )
        
        print("Successfull to fetch education from Core Data")
        return biodataModel
    } catch {
        print("Failed to fetch education from Core Data: \(error)")
        return BiodataModel(firstName: "", lastName: "", phoneNumber: "", email: "", professionalMotto: "", professionalSummary: "")
    }
}
