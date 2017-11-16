//
//  CreateEmployee.swift
//  iNote
//
//  Created by Thanh Minh on 11/15/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit
import SnapKit

protocol CreateEmployeeDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployee: UIViewController {
    var delegate: CreateEmployeeDelegate?
    
    let viewContainer: UIView = {
        let mView = UIView()
        mView.backgroundColor = UIColor.lightBlue
        return mView
    }()
    
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Name"
        return lbl
    }()
    
    let nameTf: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        setupUI()
    }
    
    @objc func handleSave(){
        guard let name = nameTf.text else { return }
        let result = CoreDataManager.shared.createEmployee(name: name)
        if let err = result.1 {
            print(err)
        } else {
            let employee = result.0
            delegate?.didAddEmployee(employee: employee!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func setupUI(){
        view.addSubview(viewContainer)
        viewContainer.snp.makeConstraints { (viewContainerSnp) in
            viewContainerSnp.top.bottom.left.right.equalToSuperview()
        }
        
        // name
        let nameStackView = UIStackView(arrangedSubviews: [nameLbl, nameTf])
        nameLbl.snp.makeConstraints { (nameLblSnp) in
            nameLblSnp.width.equalTo(96)
        }
        nameStackView.spacing = 8
        nameStackView.axis = .horizontal
        viewContainer.addSubview(nameStackView)
        
        nameStackView.snp.makeConstraints { (nameSnp) in
            nameSnp.top.equalToSuperview().offset(12)
            nameSnp.left.equalToSuperview().offset(12)
            nameSnp.right.equalToSuperview().offset(-12)
        }
    }
}
