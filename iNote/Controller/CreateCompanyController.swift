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

class CreateCompanyController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var delegate: CreateCompanyControllerDelegate?
    
    var company: Company? {
        didSet{
            nameTf.text = company?.name
            guard let founded = company?.founded else { return }
            datePickerDP.date = founded
            
//            if let imageData = company?.imageData {
//                photoIv.image = UIImage(data: imageData)
//            }
        }
    }
    
    let viewContainer: UIView = {
       let mView = UIView()
        mView.backgroundColor = UIColor.lightBlue
        return mView
    }()
    
    lazy var photoIv: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = (view.frame.width/4)/2
        iv.image = UIImage(named: "select_photo_empty")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return iv
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true) {
            if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
                self.photoIv.image = editedImage
            } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.photoIv.image = originalImage
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSelectPhoto(){
        print("Add photo")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
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
        lbl.text = "\(Date())"
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
        view.addSubview(datePickerDP)
        datePickerDP.snp.makeConstraints { (dpSnp) in
            dpSnp.top.equalTo(foundedLbl.snp.bottom).offset(12)
            dpSnp.left.right.equalToSuperview()
            dpSnp.height.equalTo(view.frame.height/4)
        }
    }
    
    let datePickerDP: UIDatePicker = {
       let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        return dp
    }()
    
    @objc func datePickerChanged (){
        foundedDateLbl.text = datePickerDP.date.formatDate()
    }
    
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
        foundedDateLbl.text = company == nil ? "\(Date().formatDate())" : "\(company?.founded?.formatDate() ?? Date().formatDate())"
        
        if let imageData = company?.imageData {
            photoIv.image = UIImage(data: imageData)
        }
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
        company.setValue(datePickerDP.date, forKey: "founded")
        
        // save image to core data
        if let image = photoIv.image {
            let imageData = UIImageJPEGRepresentation(image, 0.5)
            company.setValue(imageData, forKey: "imageData")
        }
        
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
        company?.founded = datePickerDP.date
        
        if let image = photoIv.image {
            let imageData = UIImageJPEGRepresentation(image, 0.5)
            company?.imageData = imageData
        }
        
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
        
        viewContainer.addSubview(photoIv)
        photoIv.snp.makeConstraints { (photoIvSnp) in
            photoIvSnp.top.equalToSuperview().offset(16)
            photoIvSnp.centerX.equalToSuperview()
            photoIvSnp.width.height.equalTo(view.frame.width/4)
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
            nameSnp.top.equalTo(photoIv.snp.bottom).offset(16)
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
