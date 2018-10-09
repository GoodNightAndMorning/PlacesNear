//
//  PNPublishView.swift
//  PlacesNear
//
//  Created by apple on 2018/9/29.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNPublishView: UIView {

    var deletePhotoBlock:((_ :Int) -> ())?
    var selectPhotoBlock:(() -> ())?
    var selectTagBlock:(() -> ())?
    var selectCurrentLocationBlock:(() -> ())?
    var selectLocationFromMapBlock:(() -> ())?
    
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
        tf.addTopBar()
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
    lazy var latitudeLb:UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.black
        lb.font = FontSize16
        lb.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        return lb
    }()
    lazy var longitudeLb:UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.black
        lb.font = FontSize16
        lb.setContentHuggingPriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        return lb
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
        
        
        let sectionTitleLb4 = UILabel()
        sectionTitleLb4.text = "    地点位置"
        sectionTitleLb4.font = FontSize16
        sectionTitleLb4.textColor = UIColor.black
        sectionTitleLb4.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(sectionTitleLb4)
        sectionTitleLb4.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(inputView.snp.bottom)
            make.height.equalTo(44)
        }
        
        let locationView = createLocationView()
        view.addSubview(locationView)
        locationView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(sectionTitleLb4.snp.bottom)
            make.height.equalTo(88)
        }
        
        let sectionTitleLb2 = UILabel()
        sectionTitleLb2.text = "    详细描述"
        sectionTitleLb2.font = FontSize16
        sectionTitleLb2.textColor = UIColor.black
        sectionTitleLb2.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(sectionTitleLb2)
        sectionTitleLb2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(locationView.snp.bottom)
            make.height.equalTo(44)
        }
        
        let descView = createDescView()
        view.addSubview(descView)
        descView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(sectionTitleLb2.snp.bottom)
        }
        
        createPhotosView(photos: [UIImage]())
        view.addSubview(photosView)
        photosView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(descView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
//        let sectionTitleLb3 = UILabel()
//        sectionTitleLb3.text = "    请留下您的联系方式"
//        sectionTitleLb3.font = FontSize16
//        sectionTitleLb3.textColor = UIColor.black
//        sectionTitleLb3.backgroundColor = UIColor.groupTableViewBackground
//        view.addSubview(sectionTitleLb3)
//        sectionTitleLb3.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(photosView.snp.bottom)
//            make.height.equalTo(44)
//        }
//
//        let linView = createLinkView()
//        view.addSubview(linView)
//        linView.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(sectionTitleLb3.snp.bottom)
//            make.bottom.equalToSuperview()
//        }
        
        return mainScrollView
    }
    func createLocationView() -> UIView {
        let locationView = UIView()
        
        let titleLb1 = UILabel()
        titleLb1.textColor = UIColor.black
        titleLb1.font = FontSize16
        titleLb1.text = "纬度:"
        titleLb1.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        
        let titleLb2 = UILabel()
        titleLb2.textColor = UIColor.black
        titleLb2.font = FontSize16
        titleLb2.text = "纬度:"
        titleLb2.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        
        let grayLine = UIView()
        grayLine.backgroundColor = UIColor.groupTableViewBackground
        
        let btn1 = UIButton(type: UIButtonType.custom)
        btn1.setTitle("当前位置", for: UIControlState.normal)
        btn1.backgroundColor = UIColor.black
        btn1.layer.cornerRadius = 5
        btn1.layer.masksToBounds = true
        btn1.titleLabel?.font = FontSize14
        btn1.addTarget(self, action: #selector(selectCurrentLocationAction), for: UIControlEvents.touchUpInside)
        
        let btn2 = UIButton(type: UIButtonType.custom)
        btn2.setTitle("地图选择", for: UIControlState.normal)
        btn2.backgroundColor = UIColor.black
        btn2.layer.cornerRadius = 5
        btn2.layer.masksToBounds = true
        btn2.titleLabel?.font = FontSize14
        btn2.addTarget(self, action: #selector(selectLocationFromMapAction), for: UIControlEvents.touchUpInside)
        
        locationView.addSubview(titleLb1)
        locationView.addSubview(titleLb2)
        locationView.addSubview(grayLine)
        locationView.addSubview(btn1)
        locationView.addSubview(btn2)
        locationView.addSubview(latitudeLb)
        locationView.addSubview(longitudeLb)
        
        titleLb1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.centerY.equalTo(locationView.snp.top).offset(22)
        }
        titleLb2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.centerY.equalTo(locationView.snp.top).offset(66)
        }
        grayLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(locationView.snp.top).offset(44)
            make.left.equalToSuperview().offset(25)
            make.height.equalTo(1)
            make.right.equalTo(btn1.snp.left).offset(-15)
        }
        btn1.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLb1)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.width.equalTo(80)
        }
        btn2.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLb2)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
            make.width.equalTo(80)
        }
        
        latitudeLb.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLb1)
            make.left.equalTo(titleLb1.snp.right).offset(10)
            make.right.equalTo(btn1.snp.left).offset(-15)
        }
        longitudeLb.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLb2)
            make.left.equalTo(titleLb2.snp.right).offset(10)
            make.right.equalTo(btn2.snp.left).offset(-15)
        }
        
        return locationView
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
            if (dic["title"] as! String) == "地点标签:" {
                
                let btn1 = UIButton(type: UIButtonType.custom)
                btn1.setTitle("选择标签", for: UIControlState.normal)
                btn1.backgroundColor = UIColor.black
                btn1.layer.cornerRadius = 5
                btn1.layer.masksToBounds = true
                btn1.titleLabel?.font = FontSize14
                btn1.addTarget(self, action: #selector(selectTagAction), for: UIControlEvents.touchUpInside)
                
                view.addSubview(btn1)
                
                (dic["content"] as! UIView).snp.makeConstraints { (make) in
                    make.left.equalTo(titleLb.snp.right).offset(10)
                    make.top.equalToSuperview().offset(15)
                    make.bottom.equalToSuperview().offset(-15)
                    make.right.equalTo(btn1.snp.left).offset(-15)
                }
                btn1.snp.makeConstraints { (make) in
                    make.centerY.equalTo((dic["content"] as! UIView).snp.centerY)
                    make.height.equalTo(25)
                    make.width.equalTo(80)
                    make.right.equalToSuperview().offset(-15)
                }
            }else{
                (dic["content"] as! UIView).snp.makeConstraints { (make) in
                    make.left.equalTo(titleLb.snp.right).offset(10)
                    make.top.equalToSuperview().offset(15)
                    make.bottom.equalToSuperview().offset(-15)
                    make.right.equalToSuperview().offset(-15)
                }
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
    func createPhotosView(photos:[UIImage]) {
        for view in photosView.subviews {
            view.removeFromSuperview()
        }
        //TODO:照片UI
        
        var arr = photos
        if arr.count < 9 {
            arr.append(UIImage(named: "相机2")!)
        }
        
        let width:CGFloat = (KScreenWidth - 50) / 4
        var tmpImageView = UIImageView()
        for i in 0..<arr.count {
            let row:Int = i / 4
            let num:Int = i % 4
            
            let imageView = UIImageView()
            imageView.image = arr[i]
            
            self.photosView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(10.0 + (width + 10.0) * CGFloat(num))
                make.top.equalToSuperview().offset(10.0 + (width + 10) * CGFloat(row))
                make.width.equalTo(width)
                make.height.equalTo(width)
            }
            
            tmpImageView = imageView
            
            if photos.count < 9 {
                if i != arr.count - 1 {
                    let deleteBtn = UIButton(type: UIButtonType.custom)
                    deleteBtn.tag = i
                    deleteBtn.setImage(UIImage(named: "删除1.png"), for: UIControlState.normal)
                    deleteBtn .addTarget(self, action: #selector(deletePhotoAction(btn:)), for: UIControlEvents.touchUpInside)
                    self.photosView.addSubview(deleteBtn)
                    deleteBtn.snp.makeConstraints { (make) in
                        make.right.equalTo(imageView.snp.right)
                        make.top.equalTo(imageView.snp.top)
                    }
                }else {
                    let tap = UITapGestureRecognizer(target: self, action: #selector(selectPhotoAction))
                    imageView.isUserInteractionEnabled = true
                    imageView.addGestureRecognizer(tap)
                }
            }else{
                let deleteBtn = UIButton(type: UIButtonType.custom)
                deleteBtn.tag = i
                deleteBtn.setImage(UIImage(named: "删除1.png"), for: UIControlState.normal)
                deleteBtn .addTarget(self, action: #selector(deletePhotoAction(btn:)), for: UIControlEvents.touchUpInside)
                self.photosView.addSubview(deleteBtn)
                deleteBtn.snp.makeConstraints { (make) in
                    make.right.equalTo(imageView.snp.right)
                    make.top.equalTo(imageView.snp.top)
                }
            
            }
        }
        
        tmpImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.photosView.snp.bottom).offset(-10)
        }
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
extension PNPublishView {
    @objc func selectPhotoAction() {
        if let block = selectPhotoBlock {
            block()
        }
    }
    @objc func deletePhotoAction(btn:UIButton) {
        if let block = deletePhotoBlock {
            block(btn.tag)
        }
    }
    @objc func selectTagAction() {
        if let block = selectTagBlock {
            block()
        }
    }
    @objc func selectCurrentLocationAction() {
        if let block = selectCurrentLocationBlock {
            block()
        }
    }
    @objc func selectLocationFromMapAction() {
        if let block = selectLocationFromMapBlock {
            block()
        }
    }
}
