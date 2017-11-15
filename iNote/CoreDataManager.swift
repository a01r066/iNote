//
//  INoteDataService.swift
//  iNote
//
//  Created by Thanh Minh on 11/12/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataManager {
    // the instant live forever as long as your application running
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "INoteDataModel")
        container.loadPersistentStores(completionHandler: { (storeDesc, err) in
            if let err = err {
                fatalError("Loading store failed. \(err)")
            }
        })
        return container
    }()
    
    func fetchCompanies() -> [Company]{
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            return companies
        } catch let fetchErr {
            fatalError("Fetch store failed. \(fetchErr)")
        }
    }
}
