//
//  PNHomeViewController.swift
//  PlacesNear
//
//  Created by apple on 2018/9/27.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNHomeViewController: SZViewController {
    
    var allViews:PNHomeView = PNHomeView()

    var mapView:PNMapView = PNMapView()
    
    let tags:[String] = ["公交站","地铁站","电动车维修店","四儿子店","商业广场","垃圾回收站"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initMapView()
        self.initNavi()
        self.initUi()
        self.initData()
        self.initEvents()
    }
}

// MARK: - 设置数据
extension PNHomeViewController {
    func initData() {
        self.allViews.tagsView.setTags(tags: tags)
    }
}
// MARK: - 事件
extension PNHomeViewController {
    @objc func setAction() {
        //TODO:设置事件
    }
    func initEvents() {
        self.allViews.clickPublishBtnBlock = {
            let vc = PNPublishViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.allViews.clickTitleViewBlock = {
            //TODO:点击导航栏标题事件
            UIView.animate(withDuration: 1, animations: {
                self.allViews.tagsView.isHidden = !self.allViews.tagsView.isHidden
            })
            self.allViews.titleIcon.image = self.allViews.tagsView.isHidden ? UIImage(named: "arrows_down") : UIImage(named: "arrows_up")
        }
        self.allViews.clickLocationBtnBlock = {
            //TODO:点击定位按钮事件
        }
        self.allViews.rulerView.distanceRulerBlock = {
            distance in
            //TODO:距离尺拖动事件
        }
        self.allViews.tagsView.selectTapBlock = {
            index in
            //TODO:选择tag事件
            self.allViews.tagsView.isHidden = true
            
            self.allViews.titleIcon.image = UIImage(named: "arrows_down")

            self.allViews.titleLb.text = self.tags[index]
        }
        self.allViews.tagsView.openAllTagsBlock = {
            let vc = PNTagsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            vc.selectTagBlock = {
                tagName in
                //TODO:所有标签页面回调事件
                self.allViews.titleLb.text = tagName
                
                self.allViews.titleIcon.image = UIImage(named: "arrows_down")
            }
            
            self.allViews.tagsView.isHidden = true
        }
    }
}

// MARK: - UI
extension PNHomeViewController {
    func initMapView() {
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    func initNavi() {
        
        self.navigationItem.titleView = allViews.titleView
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: allViews.cityLb)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_set"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(setAction))
    
    }
    func initUi() {
        self.view.addSubview(allViews.publishBtn)
        allViews.publishBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        self.view.addSubview(allViews.locationBtn)
        allViews.locationBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-150)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(allViews.rulerView)
        allViews.rulerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(allViews.locationBtn).offset(5)
            make.bottom.equalTo(allViews.locationBtn.snp.top).offset(-20)
            make.width.equalTo(55)
            make.height.equalTo(200)
        }
        
        self.view.addSubview(allViews.tagsView)
        allViews.tagsView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)!)
        }
    }
}


