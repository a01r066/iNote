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
            fatalError("Fetch company failed. \(fetchErr)")
        }
    }
    
    func fetchEmployess() -> ([Employee]?, Error?) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        
        do {
            let employees = try context.fetch(fetchRequest)
            return (employees, nil)
        } catch let err {
            return (nil, err)
        }
    }
    
    func createEmployee(name: String) -> (Employee?, Error?) {
        let context = persistentContainer.viewContext
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
        
        employee.setValue(name, forKey: "name")
        
        do {
            try context.save()
            return (employee as? Employee, nil)
        } catch let saveErr {
            return (nil, saveErr)
        }
    }
}
