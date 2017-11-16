//
//  INoteDataService.swift
//  iNote
//
//  Created by Thanh Minh on 11/12/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit
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
    
    func createEmployee(employeeName: String, company: Company) -> (Employee?, Error?) {
        let context = persistentContainer.viewContext
        
        //create an employee
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        employee.company = company
        
        employee.setValue(employeeName, forKey: "name")
        
        let employeeInfo = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInfo", into: context) as! EmployeeInfo
        
        employeeInfo.taxId = "456"
        
        //        employeeInfo.setValue("456", forKey: "taxId")
        
        employee.employeeInfo = employeeInfo
        
        do {
            try context.save()
            // save succeeds
            return (employee, nil)
        } catch let err {
            print("Failed to create employee:", err)
            return (nil, err)
        }
        
    }
}
