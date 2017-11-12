//
//  ViewController.swift
//  iNote
//
//  Created by Thanh Minh on 11/11/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController, CreateCompanyControllerDelegate {
    let cellId = "cellId"
    var companies: [Company] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCompanies()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "Companies"
        
        tableView.backgroundColor = .darkBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
        
        tableView.tableFooterView = UIView()
    }
    
    func fetchCompanies(){
        // initialization core data stack
        let persistentContainer = NSPersistentContainer(name: "INoteDataModel")
        persistentContainer.loadPersistentStores { (storeDesc, err) in
            if let err = err {
                fatalError("Loading of store failed. \(err)")
            }
        }

        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            companies.forEach({ (company) in
                print(company.name ?? "")
            })
        } catch let fetchErr {
            fatalError("Fetch store failed. \(fetchErr)")
        }
    }
    
    func didAddCompany(company: Company) {
//        companies.append(company)
//        let newIndexPath = IndexPath(row: companies.count-1, section: 0)
//        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightBlue
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .tealColor
        
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.name
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    @objc func handleAddCompany(){
        let createCompanyVC = CreateCompanyController()
        createCompanyVC.delegate = self
        let navController = CustomNavController(rootViewController: createCompanyVC)
        present(navController, animated: true, completion: nil)
    }
}

