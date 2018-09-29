//
//  PNTagsTableViewCell.swift
//  PlacesNear
//
//  Created by apple on 2018/9/29.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNTagsTableViewCell: UITableViewCell {

    private var tagName:String?
    func setTags(tagName:String) {
        self.tagName = tagName
        
        titleLb.text = tagName
    }
    
    lazy var titleLb:UILabel = {
        let lb = UILabel()
        lb.font = FontSize14
        lb.textColor = UIColor.black
        return lb
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initUi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PNTagsTableViewCell {
    func initUi() {

        self.contentView.addSubview(titleLb)
        
        let icon = UIImageView()
        icon.image = UIImage(named: "location")
        self.contentView.addSubview(icon)

        icon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        titleLb.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(15)
        }
    }
}
