//
//  PNPublishViewController.swift
//  PlacesNear
//
//  Created by apple on 2018/9/29.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNPublishViewController: SZViewController {

    let allView:PNPublishView = PNPublishView()
    
    var photos:[UIImage] = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "发布附近地点"
        self.view.backgroundColor = UIColor.white
        
        self.initUi()
        self.initEvents()
    }
}

// MARK: - 初始化事件
extension PNPublishViewController {
    func initEvents() {
        allView.submitBtn.willClickBtnBlock = {
            //TODO:点击提交按钮事件
            
            if PNUser.shareInstance.name == nil || PNUser.shareInstance.name?.count == 0 {
                PNHud.shareInstance.showHud(message: "请先登录", delay: 2, dismissBlock: {
                    let vc = PNLoginViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                })
                return
            }
            
            guard let placeName = self.allView.placeNameTf.text else {
                PNHud.shareInstance.showHud(message: "请输入地点名称", delay: 2, dismissBlock: nil)
                return
            }
            if placeName.count == 0 {
                PNHud.shareInstance.showHud(message: "请输入地点名称", delay: 2, dismissBlock: nil)
                return
            }
            
            guard let tagName = self.allView.placeTagTf.text else {
                PNHud.shareInstance.showHud(message: "请输入地点标签", delay: 2, dismissBlock: nil)
                return
            }
            if tagName.count == 0 {
                PNHud.shareInstance.showHud(message: "请输入地点标签", delay: 2, dismissBlock: nil)
                return
            }
            
            guard let latitude = self.allView.latitudeLb.text else {
                PNHud.shareInstance.showHud(message: "请选择地点位置", delay: 2, dismissBlock: nil)
                return
            }
            guard let longitude = self.allView.longitudeLb.text else {
                PNHud.shareInstance.showHud(message: "请选择地点位置", delay: 2, dismissBlock: nil)
                return
            }
            if latitude.count == 0 || longitude.count == 0{
                PNHud.shareInstance.showHud(message: "请选择地点位置", delay: 2, dismissBlock: nil)
                return
            }
            
            
            let phone = self.allView.placePhoneTf.text
            
            let desc = self.allView.descTv.text
            
            self.allView.submitBtn.beginAnimate()
            
            self.allView.submitBtn.clickBtnBlock = {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    self.allView.submitBtn.endAnimation(state: PNSubmitButton.SubmitState.failuer)
                })
            }
        }
        
        allView.submitBtn.finishBlock = {
            //TODO:按钮动画结束事件
            
        }
        allView.deletePhotoBlock = {
            index in
            self.photos.remove(at: index)
            self.allView.createPhotosView(photos: self.photos)
        }
        allView.selectPhotoBlock = {
            let vc = SXPhotoPickerViewController(num: Int32(self.photos.count))
            
            self.navigationController?.pushViewController(vc!, animated: true)
            
            vc?.finishSelectPhotoBlock = {
                photoArr in
                
                self.photos.append(contentsOf: photoArr as! [UIImage])
                self.allView.createPhotosView(photos: self.photos)
            }
        }
        allView.selectTagBlock = {
            let vc = PNTagsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            vc.selectTagBlock = {
                tagName in
                self.allView.placeTagTf.text = tagName
            }
        }
        allView.selectCurrentLocationBlock = {
            //TODO:选择当前地址
            self.allView.latitudeLb.text = String(format: "%f", PNLocation.shareInstance.latitude!)
            self.allView.longitudeLb.text = String(format: "%f", PNLocation.shareInstance.longitude!)
        }
        allView.selectLocationFromMapBlock = {
            //TODO:在地图上选择地址
            let vc = PNPublishLoationViewController()
            
            vc.selectLocationBlock = {
                (latitude, longitude) in
                self.allView.latitudeLb.text = String(format: "%f", latitude)
                self.allView.longitudeLb.text = String(format: "%f", longitude)
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func textFieldDidChange(textField:UITextField) {
        if textField == allView.yourPhoneTf {
            textField.limitTextCount(count: 11)
        } else if textField == allView.placePhoneTf {
            textField.limitTextCount(count: 11)
        }
    }
}
extension PNPublishViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == allView.descTv {
            textView.limitTextCount(count: 150)
            
            allView.descCountLb.text = "\(textView.text.count)/150"
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == allView.descTv {
            allView.descPlaceholderLb.isHidden = true
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == allView.descTv {
            if allView.descTv.text.count > 0 {
                allView.descPlaceholderLb.isHidden = true
            }else{
                allView.descPlaceholderLb.isHidden = false
            }
        }
    }
}
// MARK: - 初始化UI
extension PNPublishViewController {
    func initUi() {
    
        self.view.addSubview(allView.layoutMainScrollView())
        allView.mainScrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        allView.placeNameTf.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        allView.placePhoneTf.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        allView.yourPhoneTf.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        allView.descTv.delegate = self
        
        
        self.view.addSubview(allView.submitBtn)
        
        allView.submitBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(44)
            make.width.equalTo(KScreenWidth - 100)
        }
    }
}
