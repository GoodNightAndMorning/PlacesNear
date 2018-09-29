//
//  PNPublishView.swift
//  PlacesNear
//
//  Created by apple on 2018/9/29.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNPublishView: UIView {

    lazy var submitBtn:PNSubmitButton = {
        let btn = PNSubmitButton()
        return btn
    }()
    
    lazy var placeNameTf:UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.font = FontSize16
        tf.placeholder = "请输入地点名称(必填)"
        tf.addTopBar()
        return tf
    }()
    lazy var placePhoneTf:UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.font = FontSize16
        tf.keyboardType = UIKeyboardType.phonePad
        tf.placeholder = "请输入客服电话(选填)"
        tf.addTopBar()
        return tf
    }()
    lazy var placeTagTf:UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.font = FontSize16
        tf.placeholder = "请选择地点标签(必选)"
        tf.isEnabled = false
        return tf
    }()
    lazy var yourPhoneTf:UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.font = FontSize16
        tf.keyboardType = UIKeyboardType.phonePad
        tf.placeholder = "请输入您的电话(选题)"
        tf.addTopBar()
        return tf
    }()
    lazy var descTv:UITextView = {
        let tv = UITextView()
        tv.textColor = UIColor.black
        tv.font = FontSize16
        tv.addTopBar()
        return tv
    }()
    lazy var descPlaceholderLb:UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        lb.font = FontSize16
        lb.text = "请您详细描述该地点具体信息，一遍大家能更好的了解该地点~"
        lb.numberOfLines = 0
        return lb
    }()
    lazy var descCountLb:UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.black
        lb.font = FontSize16
        lb.text = "0/150"
        return lb
    }()
    lazy var photosView:UIView = {
        let view = UIView()
        return view
    }()
    lazy var mainScrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = UIColor.groupTableViewBackground
        sv.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        return sv
    }()
    func layoutMainScrollView() -> UIScrollView {
        let view = UIView()
        view.backgroundColor = UIColor.white
        mainScrollView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(KScreenWidth)
        }
        
        let sectionTitleLb1 = UILabel()
        sectionTitleLb1.text = "    地点信息"
        sectionTitleLb1.font = FontSize16
        sectionTitleLb1.textColor = UIColor.black
        sectionTitleLb1.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(sectionTitleLb1)
        sectionTitleLb1.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        let inputView = createInputView()
        
        view.addSubview(inputView)
        inputView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(sectionTitleLb1.snp.bottom)
        }
        
        let sectionTitleLb2 = UILabel()
        sectionTitleLb2.text = "    详细描述"
        sectionTitleLb2.font = FontSize16
        sectionTitleLb2.textColor = UIColor.black
        sectionTitleLb2.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(sectionTitleLb2)
        sectionTitleLb2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(inputView.snp.bottom)
            make.height.equalTo(44)
        }
        
        let descView = createDescView()
        view.addSubview(descView)
        descView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(sectionTitleLb2.snp.bottom)
        }
        
        view.addSubview(photosView)
        photosView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(descView.snp.bottom)
        }
        
        let sectionTitleLb3 = UILabel()
        sectionTitleLb3.text = "    请留下您的联系方式"
        sectionTitleLb3.font = FontSize16
        sectionTitleLb3.textColor = UIColor.black
        sectionTitleLb3.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(sectionTitleLb3)
        sectionTitleLb3.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(photosView.snp.bottom)
            make.height.equalTo(44)
        }
        
        let linView = createLinkView()
        view.addSubview(linView)
        linView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(sectionTitleLb3.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        return mainScrollView
    }
    func createInputView() -> UIView {
        let inputView = UIView()
        
        let arr:[[String:Any]] = [["title":"地点名称:","content":self.placeNameTf],
                                  ["title":"地点标签:","content":self.placeTagTf],
                                  ["title":"客服电话:","content":self.placePhoneTf]]
        var tmpView:UIView?
        for dic in arr {
            let view = UIView()
        
            let titleLb = UILabel()
            titleLb.textColor = UIColor.black
            titleLb.font = FontSize16
            titleLb.text = dic["title"] as? String
            titleLb.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
            
            let grayLine = UIView()
            grayLine.backgroundColor = UIColor.groupTableViewBackground
            
            view.addSubview(titleLb)
            
            view.addSubview(dic["content"] as! UIView)
            
            view.addSubview(grayLine)
            
            inputView.addSubview(view)
            
            titleLb.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(25)
                make.centerY.equalToSuperview()
            }
            (dic["content"] as! UIView).snp.makeConstraints { (make) in
                make.left.equalTo(titleLb.snp.right).offset(10)
                make.top.equalToSuperview().offset(15)
                make.bottom.equalToSuperview().offset(-15)
                make.right.equalToSuperview().offset(-15)
            }
            grayLine.snp.makeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(1)
            }
            
            if let tView = tmpView {
                view.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.top.equalTo(tView.snp.bottom)
                }
            }else{
                view.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.top.equalToSuperview()
                }
            }
            
            tmpView = view
        }
        tmpView?.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview()
        })
        return inputView
    }
    func createDescView() -> UIView {
        let view = UIView()
        view.addSubview(descTv)
        view.addSubview(descPlaceholderLb)
        view.addSubview(descCountLb)
        
        descTv.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(120)
        }
        descPlaceholderLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
        }
        descCountLb.snp.makeConstraints { (make) in
            make.top.equalTo(descTv.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-15)
        }
        
        let grayLine = UIView()
        grayLine.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(grayLine)
        grayLine.snp.makeConstraints { (make) in
            make.top.equalTo(descCountLb.snp.bottom).offset(15)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        return view
    }
    func createPhotosView() {
        for view in photosView.subviews {
            view.removeFromSuperview()
        }
        //TODO:照片UI
    }
    func createLinkView() -> UIView {
        let view = UIView()
        
        let titleLb = UILabel()
        titleLb.textColor = UIColor.black
        titleLb.font = FontSize16
        titleLb.text = "手机号码:"
        titleLb.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        view.addSubview(titleLb)
        
        view.addSubview(yourPhoneTf)
        titleLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
        }
        yourPhoneTf.snp.makeConstraints { (make) in
            make.left.equalTo(titleLb.snp.right).offset(10)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalToSuperview().offset(-15)
        }
        return view
    }
}
