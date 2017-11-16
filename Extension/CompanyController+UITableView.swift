//
//  CompanyController+UITableView.swift
//  iNote
//
//  Created by Thanh Minh on 11/15/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit

extension CompanyController {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employeeController = EmployeeController()
        employeeController.company = companies[indexPath.row]
        let navController = UINavigationController(rootViewController: employeeController)
        present(navController, animated: true, completion: nil)
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
}
