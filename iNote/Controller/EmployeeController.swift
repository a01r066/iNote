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
        
        // make row animation when insert item
        let section = employeeTypes.index(of: (employee.employeeInfo?.type)!)
        let row = allEmployeesList[section!].count
        let indexPath = IndexPath(row: row, section: section!)
        
        allEmployeesList[section!].append(employee)
        
        tableView.insertRows(at: [indexPath], with: .middle)
        
//        employees.append(employee)
//        fetchEmployees()
//        tableView.reloadData()
    }
    
    let cellId = "CellID"
    
    var company: Company?
//    var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancelBtItem()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        fetchEmployees()
        
        setupAddBtItem(selector: #selector(handleAddEmployee))
        tableView.backgroundColor = UIColor.darkBlue
        
        tableView.tableFooterView = UIView()
    }
    
//    var shortListEmployees = [Employee]([])
//    var longListEmployees = [Employee]([])
//    var reallyLongListEmployees = [Employee]([])
    
    var allEmployeesList: [[Employee]] = []
    
    private func fetchEmployees() {
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        
        allEmployeesList = []
        
        employeeTypes.forEach { (employeeType) in
            let employees = companyEmployees.filter { $0.employeeInfo?.type == employeeType }
            allEmployeesList.append(employees)
        }
        
//        let executives = companyEmployees.filter { (employee) -> Bool in
//            return employee.employeeInfo?.type == EmployeeType.Executive.rawValue
//        }
//
//        let seniorManagements = companyEmployees.filter { $0.employeeInfo?.type == EmployeeType.SeniorManagement.rawValue }
//
//        let interms = companyEmployees.filter { (employee) -> Bool in
//            return employee.employeeInfo?.type == EmployeeType.Interm.rawValue
//        }
//
//        allEmployeesList = [
//            executives,
//            seniorManagements,
//            companyEmployees.filter { $0.employeeInfo?.type == EmployeeType.Staff.rawValue },
//            interms
//        ]
        
//        self.employees = companyEmployees
        
//        shortListEmployees = companyEmployees.filter { (employee) -> Bool in
//            if let count = employee.name?.count {
//                return count < 6
//            }
//            return false
//        }
//
//        longListEmployees = companyEmployees.filter({ (employee) -> Bool in
//            if let count = employee.name?.count {
//                return count > 6 && count < 9
//            }
//            return false
//        })
//
//        reallyLongListEmployees = companyEmployees.filter({ (employee) -> Bool in
//            if let count = employee.name?.count {
//                return count > 9
//            }
//            return false
//        })
        
//        allEmployeesList = [shortListEmployees, longListEmployees, reallyLongListEmployees]
        
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployeesList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    var employeeTypes = [
        EmployeeType.Executive.rawValue,
        EmployeeType.SeniorManagement.rawValue,
        EmployeeType.Staff.rawValue,
        EmployeeType.Interm.rawValue
    ]
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
//        if section == 0 {
//            label.text = "First header"
//        } else if section == 1 {
//            label.text = "Second section"
//        } else {
//            label.text = "Third section"
//        }
        
        label.text = employeeTypes[section]
        
        label.backgroundColor = UIColor.lightBlue
        label.textColor = UIColor.darkBlue
        return label
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return employees.count
        return allEmployeesList[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.tealColor
        
//        let employee = employees[indexPath.row]
        let employee = allEmployeesList[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = "\(employee.name ?? "")"
        
//        if let taxId = employee.employeeInfo?.taxId {
//            cell.textLabel?.text = "\(employee.name ?? "")    \(taxId)"
//        }
        
        if let birthday = employee.employeeInfo?.birthday {
            cell.textLabel?.text = "\(employee.name ?? ""): \(employee.employeeInfo?.type ?? "") \(birthday)"
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
