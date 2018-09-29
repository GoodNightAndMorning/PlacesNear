//
//  PNTagsView.swift
//  PlacesNear
//
//  Created by apple on 2018/9/29.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNTagsView: UIView {

    var selectTapBlock:((_ :Int) -> ())?
    var openAllTagsBlock:(() -> ())?
    
    private var tags:[String]?
    func setTags(tags:[String]) {
        self.tags = tags
        
        self.createTagsBtn()
    }
    
    private var tagsView:UIView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    override func layoutSubviews() {
        self.initUi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 事件
extension PNTagsView {
    @objc func selectTagAction(tap:UITapGestureRecognizer) {
        let index = tap.view?.tag
        if let block = selectTapBlock {
            block(index!)
        }
    }
    @objc func openAllTagsAction() {
        if let block = openAllTagsBlock {
            block()
        }
    }
}

// MARK: - UI
extension PNTagsView {
    func createTagsBtn() {
        let height:CGFloat = 44
        
        guard let tagsArr = tags else { return }
        
        var tmpView:UIView = UIView()
        for i in 0..<tagsArr.count  {
            
            let view = UIView()
            view.tag = i
            let tap = UITapGestureRecognizer(target: self, action: #selector(selectTagAction(tap:)))
            view.addGestureRecognizer(tap)
            
            self.tagsView.addSubview(view)
            
            let grayLine = UIView()
            grayLine.backgroundColor = UIColor.groupTableViewBackground
            view.addSubview(grayLine)
            
            let lb = UILabel()
            lb.text = tagsArr[i]
            lb.font = FontSize14
            lb.textColor = UIColor.black
            view.addSubview(lb)
            
            let icon = UIImageView()
            icon.image = UIImage(named: "location")
            view.addSubview(icon)
            
            view.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview().offset(height * CGFloat(i))
                make.height.equalTo(height)
            }
            icon.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(15)
            }
            lb.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(icon.snp.right).offset(15)
            }
            grayLine.snp.makeConstraints { (make) in
                make.left.bottom.right.equalToSuperview()
                make.height.equalTo(1)
            }
            
            tmpView = view
        }
        tmpView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
        }
    }
    func initUi() {
        let titleLb = UILabel()
        titleLb.text = "选择附近地点的标签"
        titleLb.textColor = UIColor.black
        titleLb.font = FontSize16
        self.addSubview(titleLb)
        
        let grayLine1 = UIView()
        grayLine1.backgroundColor = UIColor.groupTableViewBackground
        self.addSubview(grayLine1)
        
        self.addSubview(self.tagsView)

        let allBtn = UIButton(type: UIButtonType.custom)
        allBtn.setTitle("展开全部标签 >>", for: UIControlState.normal)
        allBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        allBtn.titleLabel?.font = FontSize14
        allBtn.addTarget(self, action: #selector(openAllTagsAction), for: UIControlEvents.touchUpInside)
        self.addSubview(allBtn)
        
        titleLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        grayLine1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLb.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        self.tagsView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(grayLine1.snp.bottom)
        }

        allBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.tagsView.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
