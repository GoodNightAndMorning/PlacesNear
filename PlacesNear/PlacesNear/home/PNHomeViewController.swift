//
//  PNHomeViewController.swift
//  PlacesNear
//
//  Created by apple on 2018/9/27.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNHomeViewController: UIViewController {
    
    var allViews:PNHomeView = PNHomeView()
    
    var _mapView:BMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNavi()
        
        
        _mapView = BMKMapView(frame: self.view.bounds)
        self.view .addSubview(_mapView)
        
        self.initUi()
        
        self.initEvents()
    }
}

// MARK: - 事件
extension PNHomeViewController {
    @objc func setAction() {
        //TODO:设置事件
    }
    func initEvents() {
        self.allViews.clickPublishBtnBlock = {
            //TODO:发布事件
        }
        self.allViews.clickTitleViewBlock = {
            //TODO:点击导航栏标题事件
        }
    }
}

// MARK: - UI
extension PNHomeViewController {
    func initNavi() {
        self.navigationItem.titleView = allViews.titleView
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: allViews.cityLb)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "设置", style: UIBarButtonItemStyle.plain, target: self, action: #selector(setAction))
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    func initUi() {
        self.view.addSubview(allViews.publishBtn)
        allViews.publishBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }
}
