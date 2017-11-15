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
        
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellId)
        
        fetchCompanies()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "Companies"
        
        tableView.backgroundColor = .darkBlue
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
        
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
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            
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
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            companies.forEach({ (company) in
                print(company.name ?? "")
            })
            self.companies = companies
            tableView.reloadData()
        } catch let fetchErr {
            fatalError("Fetch store failed. \(fetchErr)")
        }
    }
    
    func didEditCompany(company: Company) {
        let row = companies.index(of: company)
        let indexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    func didAddCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count-1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let status = UILabel()
        status.text = "No data..."
        status.textAlignment = .center
        status.textColor = UIColor.white
        status.font = UIFont.boldSystemFont(ofSize: 16)
        return status
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count == 0 ? 150 : 0
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CompanyCell
        
        let company = companies[indexPath.row]
        cell.company = company
        
//        if let founded = company.founded {
//            cell.textLabel?.text = "\(company.name!) - Founded: \(founded.formatDate())"
//        } else {
//            cell.textLabel?.text = company.name
//        }
//        cell.textLabel?.textColor = UIColor.white
//
//        if let imageData = company.imageData {
//            let image = UIImage(data: imageData)
//            cell.imageView?.image = image
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteActionHandler)
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editActionHandler)
        
        deleteAction.backgroundColor = UIColor.lightRed
        editAction.backgroundColor = UIColor.darkBlue
        
        return [deleteAction, editAction]
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
        
        let navController = CustomNavController(rootViewController: createCompanyController)
        present(navController, animated: true, completion: nil)
        
    }
    
    @objc func handleAddCompany(){
        let createCompanyVC = CreateCompanyController()
        createCompanyVC.delegate = self
        let navController = CustomNavController(rootViewController: createCompanyVC)
        present(navController, animated: true, completion: nil)
    }
}

