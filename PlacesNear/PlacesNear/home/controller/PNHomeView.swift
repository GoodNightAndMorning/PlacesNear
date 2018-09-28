//
//  PNHomeView.swift
//  PlacesNear
//
//  Created by apple on 2018/9/28.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNHomeView: UIView {
    
    var clickPublishBtnBlock:(() -> ())?
    var clickTitleViewBlock:(() -> ())?
    
    lazy var titleView:UIView = {
        let view = UIView()
        view.addSubview(self.titleLb)
        view.addSubview(self.titleIcon)
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTitleViewAction))
        self.titleLb.snp.makeConstraints({ (make) in
            make.left.equalTo(view)
            make.top.equalTo(view)
            make.bottom.equalTo(view)
        })
        self.titleIcon.snp.makeConstraints({ (make) in
            make.centerY.equalTo(view)
            make.left.equalTo(titleLb.snp.right)
            make.right.equalTo(view)
        })
        return view
    }()
    
    lazy var titleLb:UILabel = {
        let lb = UILabel()
        lb.text = "选择地点名称"
        lb.font = FontSize18
        lb.textColor = UIColor.black
        return lb
    }()
    
    lazy var titleIcon:UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "arrows_down")
        return icon
    }()
    
    lazy var cityLb:UILabel = {
        let lb = UILabel()
        lb.text = "福州"
        lb.font = FontSize16
        lb.textColor = UIColor.black
        lb.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        return lb
    }()
    
    lazy var publishBtn:PNAnimationButton = {
        let btn = PNAnimationButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        btn.setTitle("发布", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.titleLabel?.font = FontSize16
        btn.backgroundColor = UIColor.black
        btn.layer.cornerRadius = 30
        btn.addTarget(self, action: #selector(publishAction), for: UIControlEvents.touchUpInside)
        return btn
    }()
}
extension PNHomeView {
    @objc func publishAction() {
        if let block = self.clickPublishBtnBlock {
            block()
        }
    }
    @objc func clickTitleViewAction() {
        if let block = self.clickTitleViewBlock {
            block()
        }
    }
}

