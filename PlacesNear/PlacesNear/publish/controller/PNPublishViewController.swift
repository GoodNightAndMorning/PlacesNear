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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "发布附近地点"
        self.view.backgroundColor = UIColor.white
        
        self.initUi()
        self.initEvents()
    }
}
extension PNPublishViewController {
    func initEvents() {
        allView.submitBtn.clickBtnBlock = {
            //TODO:点击提交按钮事件
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                self.allView.submitBtn.endAnimation(state: PNSubmitButton.SubmitState.failuer)
            })
        }
        allView.submitBtn.finishBlock = {
            //TODO:按钮动画结束事件
        }
    }
}
extension PNPublishViewController {
    func initUi() {
    
        self.view.addSubview(allView.layoutMainScrollView())
        allView.mainScrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        self.view.addSubview(allView.submitBtn)
        
        allView.submitBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(44)
            make.width.equalTo(KScreenWidth - 100)
        }
    }
}
