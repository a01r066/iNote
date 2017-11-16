//
//  CompanyCell.swift
//  iNote
//
//  Created by Thanh Minh on 11/15/17.
//  Copyright © 2017 Thanh Minh. All rights reserved.
//

import UIKit
import SnapKit

class CompanyCell: UITableViewCell {
    var company: Company? {
        didSet{
            if let company = company {
                if let imageData = company.imageData {
                    photoIv.image = UIImage(data: imageData)
                }
                
                nameAndFoundedLbl.text = "\(company.name ?? "") - Founded: \(company.founded?.formatDate() ?? Date().formatDate())"
                nameAndFoundedLbl.textColor = UIColor.white
                nameAndFoundedLbl.font = UIFont.systemFont(ofSize: 14)
            }
        }
    }
    
    let photoIv: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "select_photo_empty")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 50/2
        return iv
    }()
    
    let nameAndFoundedLbl: UILabel = {
       let lbl = UILabel()
        lbl.text = "Company name - Founded: Oct 25, 2015"
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews(){
        backgroundColor = UIColor.tealColor
        
        addSubview(photoIv)
        photoIv.snp.makeConstraints { (photoIvSnp) in
            photoIvSnp.left.equalToSuperview().offset(12)
            photoIvSnp.width.height.equalTo(50)
            photoIvSnp.centerY.equalToSuperview()
        }
        
        addSubview(nameAndFoundedLbl)
        nameAndFoundedLbl.snp.makeConstraints { (nameAndFoundedSnp) in
            nameAndFoundedSnp.left.equalTo(photoIv.snp.right).offset(12)
            nameAndFoundedSnp.right.equalToSuperview().offset(-12)
            nameAndFoundedSnp.centerY.equalToSuperview()
        }
    }
}
