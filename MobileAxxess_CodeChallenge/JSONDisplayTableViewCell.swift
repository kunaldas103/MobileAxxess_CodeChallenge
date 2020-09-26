//
//  JSONDisplayTableViewCell.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import UIKit
import SnapKit

class JSONDisplayTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
                   make.top.equalTo(self.contentView).offset(10)
                   make.bottom.equalTo(self.contentView).offset(-10)
                   make.left.equalTo(self.contentView).offset(10)
                   make.right.equalTo(self.contentView).offset(-10)
        }
        
        containerView.addSubview(idLabel)
        containerView.addSubview(typeLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(dataLabel)
        
        idLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView)
            make.bottom.equalTo(typeLabel.snp.top).offset(-10)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
        }
        
        typeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(dateLabel.snp.top).offset(-10)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(dataLabel.snp.top).offset(-10)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
        }
        
        dataLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(containerView)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
        }
        
       
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let idLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  .black
        return label
    }()
    
    let dataLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  .black
        return label
    }()
    
    let typeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  .black
        return label
    }()
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  .black
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
}
