//
//  ResumeCoreDataService.swift
//  ResuMate
//
//  Created by Muhammad Afif Maruf on 11/06/23.
//

import Foundation
import CoreData

func fetchSelectedEntities<T: NSManagedObject>(
    in managedObjectContext: NSManagedObjectContext,
    withIDs ids: [String],
    entityName: String
) -> [T]? {
    let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
    fetchRequest.predicate = NSPredicate(format: "id IN %@", ids)
    
    do {
        let entities = try managedObjectContext.fetch(fetchRequest)
        return entities
    } catch {
        print("Error fetching \(entityName) core data entities: \(error)")
        return nil
    }
}

func fetchSelectedBiodata(in managedObjectContext: NSManagedObjectContext) -> Person? {
    let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
    
    do {
        let persons = try managedObjectContext.fetch(fetchRequest)
        
        return persons.first
    } catch {
        print("Error fetching person core data entities: \(error)")
        return nil
    }
}

func saveResumeToCoreData(
    in managedObjectContext: NSManagedObjectContext,
    workExperienceIDs: [String],
    educationIDs: [String],
    organizationIDs: [String],
    volunteerIDs: [String],
    achievementIDs: [String],
    jobGoal: String
){
    let newResumeData = Resume(context: managedObjectContext)
    newResumeData.id = UUID()
    newResumeData.jobGoal = jobGoal
    
    // Create instances of related models
    let selectedWorkExperiences = fetchSelectedEntities(
        in: managedObjectContext,
        withIDs: workExperienceIDs,
        entityName: "WorkExperience"
    )
    
    let selectedEducations = fetchSelectedEntities(
        in: managedObjectContext,
        withIDs: educationIDs,
        entityName: "Education"
    )
    
    let selectedOrganizations = fetchSelectedEntities(
        in: managedObjectContext,
        withIDs: organizationIDs,
        entityName: "Organization"
    )
    
    let selectedVolunteers = fetchSelectedEntities(
        in: managedObjectContext,
        withIDs: volunteerIDs,
        entityName: "Volunteer"
    )
    
    let selectedAchievements = fetchSelectedEntities(
        in: managedObjectContext,
        withIDs: achievementIDs,
        entityName: "Achievement"
    )
    
    let biodata = fetchSelectedBiodata(in: managedObjectContext)
    
    // Associate selected related models with resume data
    newResumeData.workExperiences = NSSet(array: selectedWorkExperiences ?? [])
    newResumeData.educations = NSSet(array: selectedEducations ?? [])
    newResumeData.organizations = NSSet(array: selectedOrganizations ?? [])
    newResumeData.volunteers = NSSet(array: selectedVolunteers ?? [])
    newResumeData.achievements = NSSet(array: selectedAchievements ?? [])
    newResumeData.persons = biodata
    
    do {
        try managedObjectContext.save()
        print("Resume Data created successfully.")
    } catch {
        print("Error saving resume data: \(error)")
    }
}

func fetchResumeData(
    in managedObjectContext: NSManagedObjectContext,
    resumeID: UUID
) -> Resume? {
    let fetchRequest: NSFetchRequest<Resume> = Resume.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", resumeID as CVarArg)
    fetchRequest.relationshipKeyPathsForPrefetching = ["workExperiences", "educations", "organizations", "volunteers", "achievements", "persons"]
    
    do {
        let resumeData = try managedObjectContext.fetch(fetchRequest).first
        return resumeData
    } catch {
        print("Error fetching resume data: \(error)")
        return nil
    }
}

//MARK: How to access in view
// let resumeID = UUID(...) // Replace ... with the UUID of the resume you want to fetch
// if let resumeData = fetchResumeData(in: viewContext, resumeID: resumeID) {
//    // Access the fetched resume data and its related entities
//    let jobGoal = resumeData.jobGoal
//    let workExperiences = resumeData.workExperiences
//    let educations = resumeData.educations
//    let organizations = resumeData.organizations
//    let volunteers = resumeData.volunteers
//    let achievements = resumeData.achievements
//    let biodata = resumeData.persons
//
//    // Use the fetched resume data and related entities as needed
// } else {
//    // Handle the case when the resume data is not found
// }
