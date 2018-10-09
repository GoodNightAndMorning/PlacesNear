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
    var clickLocationBtnBlock:(() -> ())?
    
    lazy var titleView:UIView = {
        let view = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickTitleViewAction))
        view.addGestureRecognizer(tap)
        
        view.addSubview(self.titleLb)
        view.addSubview(self.titleIcon)
        
        self.titleLb.snp.makeConstraints({ (make) in
            make.left.equalTo(view)
            make.top.equalTo(view)
            make.bottom.equalTo(view)
        })
        self.titleIcon.snp.makeConstraints({ (make) in
            make.centerY.equalTo(view)
            make.left.equalTo(titleLb.snp.right).offset(3)
            make.right.equalTo(view)
        })
        return view
    }()
    
    lazy var titleLb:UILabel = {
        let lb = UILabel()
        lb.text = "选择标签"
        lb.font = FontSize18
        lb.textColor = UIColor.white
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
        lb.textColor = UIColor.white
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
    
    lazy var locationBtn:UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(UIImage(named: "location"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clickLocationBtnAction), for: UIControlEvents.touchUpInside)
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    lazy var rulerView:PNDistanceRulerView = {
        let view = PNDistanceRulerView()
        let arr:[String] = ["1","2","5","10","20"]
        view.setLimbArr(limbArr: arr)

        return view
    }()
    lazy var distanceLb:UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.black
        lb.font = FontSize14
        lb.text = "1.00公里"
        return lb
    }()
    
    lazy var tagsView:PNTagsView = {
        let view = PNTagsView()
        view.isHidden = true

        return view
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
    @objc func clickLocationBtnAction() {
        if let block = self.clickLocationBtnBlock {
            block()
        }
    }
}

