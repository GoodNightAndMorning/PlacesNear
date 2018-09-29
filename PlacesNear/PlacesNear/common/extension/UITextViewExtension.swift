//
//  UITextViewExtension.swift
//  PlacesNear
//
//  Created by zsx on 2018/9/29.
//  Copyright © 2018年 zsx. All rights reserved.
//

import Foundation

extension UITextView {
    func addTopBar() {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle("完成", for: UIControlState.normal)
        btn.titleLabel?.font = FontSize16
        btn.backgroundColor = UIColor.black
        btn.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: 44)
        btn.addTarget(self, action: #selector(closeKeyboardAction), for: UIControlEvents.touchUpInside)
        self.inputAccessoryView = btn
        print("aaa")
    }
    @objc private func closeKeyboardAction() {
        self.resignFirstResponder()
    }
}
