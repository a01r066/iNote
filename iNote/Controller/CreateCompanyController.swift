//
//  CreateCompanyController.swift
//  iNote
//
//  Created by Thanh Minh on 11/11/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController {
    var delegate: CreateCompanyControllerDelegate?
    
    var company: Company? {
        didSet{
            nameTf.text = company?.name
        }
    }
    
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
    
    let foundedLbl: UILabel = {
       let lbl = UILabel()
        lbl.text = "Founded"
        return lbl
    }()
    
    let foundedDateLbl: UILabel = {
       let lbl = UILabel()
        lbl.text = "Oct 23, 2017"
        return lbl
    }()
    
    let pickerBt: UIButton = {
       let bt = UIButton()
        bt.showsTouchWhenHighlighted = true
        bt.setBackgroundImage(#imageLiteral(resourceName: "ic_arrow_drop_down_18pt"), for: .normal)
        bt.addTarget(self, action: #selector(handleDatePicker), for: .touchUpInside)
        return bt
    }()
    
    @objc func handleDatePicker(){
        print("Date")
    }
    
    @objc func handleCancel(){
        print("Cancel")
        
    }
    
    @objc func handleDone(){
        print("Done")
    }
    
    let datePickerDP: UIDatePicker = {
       let dp = UIDatePicker()
        dp.datePickerMode = .date
        return dp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        view.backgroundColor = UIColor.darkBlue
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    
    @objc func handleSave(){
        if company == nil {
            createCompany()
        } else {
            updateCompany()
        }
    }
    
    private func createCompany(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTf.text, forKey: "name")
        
        // perform the save
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didAddCompany(company: company as! Company)
            })
        } catch let saveErr {
            fatalError("Save error. \(saveErr)")
        }
    }
    
    private func updateCompany(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        company?.name = nameTf.text
        // perform the save
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditCompany(company: self.company!)
            })
        } catch let saveErr {
            fatalError("Save error. \(saveErr)")
        }
    }
    
    @objc func handleBack(){
        dismiss(animated: true, completion: nil)
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
            nameSnp.top.equalToSuperview().offset(16)
            nameSnp.left.equalToSuperview().offset(12)
            nameSnp.right.equalToSuperview().offset(-12)
        }
        
        // founded
        let foundedStackView = UIStackView(arrangedSubviews: [foundedLbl, foundedDateLbl, pickerBt])
        foundedLbl.snp.makeConstraints { (foundedLblSnp) in
            foundedLblSnp.width.equalTo(96)
        }
        foundedStackView.spacing = 8
        foundedStackView.axis = .horizontal
        viewContainer.addSubview(foundedStackView)
        foundedStackView.snp.makeConstraints { (foundedSnp) in
            foundedSnp.top.equalTo(nameStackView.snp.bottom).offset(8)
            foundedSnp.leading.trailing.equalTo(nameStackView)
        }
    }
}
