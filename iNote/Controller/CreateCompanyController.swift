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
}

class CreateCompanyController: UIViewController {
    var delegate: CreateCompanyControllerDelegate?
    
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
        
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc func handleSave(){
//        dismiss(animated: true) {
//            guard let name = self.nameTf.text else { return }
//            let company = Company(json: ["id": "cp1001", "name": name, "imageURL": "https://www.google.com.vn/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"])
//            self.delegate?.didAddCompany(company: company!)
//        }
        
        // initialization core data stack
        let persistentContainer = NSPersistentContainer(name: "INoteDataModel")
        persistentContainer.loadPersistentStores { (storeDesc, err) in
            if let err = err {
                fatalError("Loading of store failed. \(err)")
            }
        }
        let context = persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTf.text, forKey: "name")
        
        // perform the save
        do {
            try context.save()
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
