//
//  ViewController.swift
//  iNote
//
//  Created by Thanh Minh on 11/11/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
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
        companies = [
            Company(json: ["id": "cp1001", "name": "Google Inc", "imageURL": "https://www.google.com.vn/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"])!,
            Company(json: ["id": "cp1002", "name": "Apple Inc", "imageURL": "https://www.google.com.vn/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"])!,
            Company(json: ["id": "cp1003", "name": "Yahoo Inc", "imageURL": "https://www.google.com.vn/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"])!,
            Company(json: ["id": "cp1004", "name": "Facebook Inc", "imageURL": "https://www.google.com.vn/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"])!,
            Company(json: ["id": "cp1005", "name": "Microsoft Inc", "imageURL": "https://www.google.com.vn/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"])!
        ]
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
        let navController = CustomNavController(rootViewController: createCompanyVC)
        present(navController, animated: true, completion: nil)
    }
}

