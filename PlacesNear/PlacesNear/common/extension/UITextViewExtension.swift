//
//  UITextViewExtension.swift
//  PlacesNear
//
//  Created by zsx on 2018/9/29.
//  Copyright © 2018年 zsx. All rights reserved.
//

import Foundation

extension UITextView {
    /// 现在textField输入字数
    ///
    /// - Parameter count: 字数
    func limitTextCount(count:Int) {
        if (self.text?.count)! > count {
            let markedRange:UITextRange? = self.markedTextRange
            if markedRange != nil {
                return
            }
            let str:String = self.text!
            let index = str.index(str.startIndex, offsetBy: count)
            self.text = String(str[str.startIndex..<index])
        }
    }
    /// 添加键盘工具栏
    func addTopBar() {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle("完成", for: UIControlState.normal)
        btn.titleLabel?.font = FontSize16
        btn.backgroundColor = UIColor.black
        btn.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: 44)
        btn.addTarget(self, action: #selector(closeKeyboardAction), for: UIControlEvents.touchUpInside)
        self.inputAccessoryView = btn
    }
    @objc private func closeKeyboardAction() {
        self.resignFirstResponder()
    }
}
