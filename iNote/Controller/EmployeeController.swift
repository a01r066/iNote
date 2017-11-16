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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        fetchEmployees()
        
        setupAddBtItem(selector: #selector(handleAddEmployee))
        tableView.backgroundColor = UIColor.darkBlue
        
        tableView.tableFooterView = UIView()
    }
    
    func fetchEmployees(){
        let result = CoreDataManager.shared.fetchEmployess()
        if let err = result.1 {
            print(err)
        } else {
            self.employees = result.0!
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.tealColor
        let employee = employees[indexPath.row]
        cell.textLabel?.text = employee.name
        return cell
    }
    
    @objc func handleAddEmployee(){
        let createEmployee = CreateEmployee()
        createEmployee.delegate = self
        navigationController?.pushViewController(createEmployee, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }
}
