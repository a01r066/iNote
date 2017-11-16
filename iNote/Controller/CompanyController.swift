//
//  ViewController.swift
//  iNote
//
//  Created by Thanh Minh on 11/11/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit
import CoreData

class CompanyController: UITableViewController {
    let cellId = "cellId"
    var companies: [Company] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellId)
        
        fetchCompanies()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "Companies"
        
        tableView.backgroundColor = .darkBlue
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
        setupAddBtItem(selector: #selector(handleAddCompany))
        
        tableView.tableFooterView = UIView()
    }
    
    @objc private func handleReset(){
        print("Attempt to reset data")
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        // cach 1
//        companies.forEach { (company) in
//            context.delete(company)
//        }
        
        // cach 2
        // make row animation when delete
        let companyBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        
        do {
            try context.execute(companyBatchDeleteRequest)
            
            var indexPathsToRemove = [IndexPath]([])
            for(index, _) in companies.enumerated(){
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            
            companies.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
            
            tableView.reloadData()
        } catch let delErr {
            fatalError("Delete failed. \(delErr)")
        }
    }
    
    func fetchCompanies(){
        self.companies = CoreDataManager.shared.fetchCompanies()
    }
    
    func deleteActionHandler(action: UITableViewRowAction, indexPath: IndexPath){
        // delete from tableview
        let company = companies[indexPath.row]
        self.companies.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // delete from core data
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        context.delete(company)
        
        do {
            try context.save()
        } catch let saveErr {
            fatalError("Delete item failed: \(saveErr)")
        }
    }
    
    func editActionHandler(action: UITableViewRowAction, indexPath: IndexPath){
        let company = companies[indexPath.row]
        print("Attempt to edit company: \(company.name ?? "")")
        
        let createCompanyController = CreateCompanyController()
        createCompanyController.delegate = self
        createCompanyController.company = company
        
        let navController = UINavigationController(rootViewController: createCompanyController)
        present(navController, animated: true, completion: nil)
        
    }
    
    @objc func handleAddCompany(){
        let createCompanyVC = CreateCompanyController()
        createCompanyVC.delegate = self
        let navController = UINavigationController(rootViewController: createCompanyVC)
        present(navController, animated: true, completion: nil)
    }
}

