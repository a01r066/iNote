//
//  EmployeeController.swift
//  iNote
//
//  Created by Thanh Minh on 11/15/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit
import CoreData

class EmployeeController: UITableViewController, CreateEmployeeDelegate {
    func didAddEmployee(employee: Employee) {
        employees.append(employee)
        tableView.reloadData()
    }
    
    let cellId = "CellID"
    
    var company: Company?
    var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancelBtItem()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        fetchEmployees()
        
        setupAddBtItem(selector: #selector(handleAddEmployee))
        tableView.backgroundColor = UIColor.darkBlue
        
        tableView.tableFooterView = UIView()
    }
    
    private func fetchEmployees() {
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        self.employees = companyEmployees
        
        //        print("Trying to fetch employees..")
        //
        //        let context = CoreDataManager.shared.persistentContainer.viewContext
        //
        //        let request = NSFetchRequest<Employee>(entityName: "Employee")
        //
        //        do {
        //            let employees = try context.fetch(request)
        //            self.employees = employees
        //
        ////            employees.forEach{print("Employee name:", $0.name ?? "")}
        //
        //        } catch let err {
        //            print("Failed to fetch employees:", err)
        //        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.tealColor
        
        let employee = employees[indexPath.row]
        cell.textLabel?.text = employee.name
        
        if let taxId = employee.employeeInfo?.taxId {
            cell.textLabel?.text = "\(employee.name ?? "")    \(taxId)"
        }
        
        return cell
    }
    
    @objc func handleAddEmployee(){
        let createEmployee = CreateEmployee()
        createEmployee.company = company
        createEmployee.delegate = self
        let navController = UINavigationController(rootViewController: createEmployee)
        present(navController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }
}
