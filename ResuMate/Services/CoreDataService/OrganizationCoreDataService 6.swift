//
//  OrganizationCoreDataService.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 10/06/23.
//

import Foundation
import CoreData

//MARK: Func to save model to core data
func saveOrganizationToCoreData(_ organizations: [OrganizationModel], context: NSManagedObjectContext) {
    //setup date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyyy"
    
    for organization in organizations {
        let newOrganization = Organization(context: context)
        newOrganization.organization = organization.organization
        newOrganization.role = organization.role
        newOrganization.startDate = dateFormatter.date(from: organization.startDate!)
        newOrganization.endDate = dateFormatter.date(from: organization.endDate!)
        newOrganization.organizationDescription = organization.description
        
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
func updateOrganizationInCoreData(_ organization: OrganizationModel, context: NSManagedObjectContext) {
    let fetchRequest: NSFetchRequest<Organization> = Organization.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", organization.id!.uuidString) // Assuming organization is the unique identifier
    
    //setup date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyyy"
    
    do {
        let results = try context.fetch(fetchRequest)
        if let existingOrganization = results.first {
            // Update the properties
            existingOrganization.organization = organization.organization
            existingOrganization.role = organization.role
            existingOrganization.startDate = dateFormatter.date(from: organization.startDate!)
            existingOrganization.endDate = dateFormatter.date(from: organization.endDate!)
            existingOrganization.organizationDescription = organization.description
            
            // Save the changes to Core Data
            do {
                try context.save()
                print("Successfully updated organization in Core Data")
            } catch {
                print("Failed to update organization in Core Data: \(error)")
            }
        } else {
            print("Organization not found in Core Data")
        }
    } catch {
        print("Error fetching organization from Core Data: \(error)")
    }
}

//MARK: Func to fetch model from core data
func fetchOrganizationFromCoreData(context: NSManagedObjectContext) -> [OrganizationModel] {
    do {
        let fetchRequest: NSFetchRequest<Organization> = Organization.fetchRequest()
        let organizations = try context.fetch(fetchRequest)
        
        // Convert Education objects to EducationModel
        let organizationModels = organizations.map { organization in
            OrganizationModel(
                id: UUID(),
                role: organization.role,
                organization: organization.organization,
                startDate: organization.startDate?.toString(),
                endDate: organization.endDate?.toString(),
                description: organization.organization
            )
        }
        
        print("Successfull to fetch education from Core Data")
        return organizationModels
    } catch {
        print("Failed to fetch education from Core Data: \(error)")
        return []
    }
}
