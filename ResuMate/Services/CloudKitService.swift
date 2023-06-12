//
//  CloudKitService.swift
//  ResuCreate
//
//  Created by Muhammad Adha Fajri Jonison on 12/06/23.
//

import Foundation
import CloudKit

class CloudKitService: ObservableObject {
    @Published var apiKey: ApiKey?
    private let container: CKContainer
    private let database: CKDatabase

    init() {
        container = CKContainer(identifier: "iCloud.resumate")
        database = container.publicCloudDatabase
    }
    
    func fetchAuthorizationKey(recordName: String, completion: @escaping (Result<String, Error>) -> Void) {
         let recordID = CKRecord.ID(recordName: recordName)
         
         database.fetch(withRecordID: recordID) { result, error in
             if let error = error {
                 print(error.localizedDescription)
                 completion(.failure(error))
                 return
             }
             
             guard let result = result, let key = result["AuthorizationKey"] as? String else {
                 completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                 return
             }
             
             completion(.success(key))
         }
     }
}
