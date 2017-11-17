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
    var company: Company?
    
    var delegate: CreateEmployeeDelegate?
    
    let viewContainer: UIView = {
        let mView = UIView()
        mView.backgroundColor = UIColor.lightBlue
        return mView
    }()
    
    // name
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
    
    // birthday
    let birthLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Birthday"
        return lbl
    }()
    
    let birthTf: UITextField = {
        let tf = UITextField()
        tf.placeholder = "MM/dd/yyyy"
        return tf
    }()
    
    // position
    let positionSg: UISegmentedControl = {
        let items = [
            EmployeeType.Executive.rawValue,
            EmployeeType.SeniorManagement.rawValue,
            EmployeeType.Staff.rawValue,
            EmployeeType.Interm.rawValue
        ]
        let sg = UISegmentedControl(items: items)
        sg.tintColor = UIColor.lightRed
        sg.selectedSegmentIndex = 0
        return sg
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCancelBtItem()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        setupUI()
    }
    
    // MARK: - you can note here
    @objc func handleSave(){
        guard let employeeName = nameTf.text else { return }
        guard let company = self.company else { return }
        
        guard let dateString = birthTf.text else { return }
        if dateString.isEmpty {
            showError(title: "Empty birth", message: "Enter your birthday!")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let birthday = dateFormatter.date(from: dateString) else {
            showError(title: "Invalid Date", message: "Birthday date entered not valid")
            return
        }
        
        guard let employeeType = positionSg.titleForSegment(at: positionSg.selectedSegmentIndex) else { return }
        
        let result = CoreDataManager.shared.createEmployee(employeeName: employeeName, birthday: birthday, employeeType: employeeType, company: company)
        if let err = result.1 {
            print(err)
        } else {
            dismiss(animated: true, completion: {
                guard let employee = result.0 else { return }
                self.delegate?.didAddEmployee(employee: employee)
            })
//            navigationController?.popViewController(animated: true)
        }
    }
    
    func showError(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
        
        // birthday
        let birthStackView = UIStackView(arrangedSubviews: [birthLbl, birthTf])
        birthLbl.snp.makeConstraints { (birthLblSnp) in
            birthLblSnp.width.equalTo(96)
        }
        nameStackView.spacing = 8
        nameStackView.axis = .horizontal
        viewContainer.addSubview(birthStackView)
        
        birthStackView.snp.makeConstraints { (birthStackViewSnp) in
            birthStackViewSnp.top.equalTo(nameStackView.snp.bottom).offset(8)
            birthStackViewSnp.left.equalToSuperview().offset(12)
            birthStackViewSnp.right.equalToSuperview().offset(-12)
        }
        
        // segment control
        view.addSubview(positionSg)
        positionSg.snp.makeConstraints { (positionSnp) in
            positionSnp.top.equalTo(birthStackView.snp.bottom).offset(12)
            positionSnp.width.equalTo(view.frame.width*0.9)
            positionSnp.height.equalTo(31)
            positionSnp.centerX.equalToSuperview()
        }
    }
}
