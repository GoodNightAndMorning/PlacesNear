//
//  PNLoginView.swift
//  PlacesNear
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNLoginView: UIView {

    var sendCodeBlock:(() -> ())?
    var loginBlock:(() -> ())?
    
    lazy var phoneTf:UITextField = {
        let tf = UITextField()
        
        let leftView = UIButton(type: UIButtonType.custom)
        leftView.setImage(UIImage(named: "login_account_icon"), for: UIControlState.normal)
        leftView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        leftView.isEnabled = false
        
        tf.leftView = leftView
        tf.leftViewMode = UITextFieldViewMode.always
        
        tf.font = FontSize16
        tf.placeholder = "请输入手机号码"
        tf.textColor = UIColor.black

        tf.layer.cornerRadius = 5
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        
        tf.addTopBar()
        tf.keyboardType = UIKeyboardType.phonePad
        return tf
    }()
    lazy var codeTf:UITextField = {
        let tf = UITextField()
        
        let leftView = UIButton(type: UIButtonType.custom)
        leftView.setImage(UIImage(named: "login_account_icon"), for: UIControlState.normal)
        leftView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        leftView.isEnabled = false
        
        tf.leftView = leftView
        tf.leftViewMode = UITextFieldViewMode.always
        
        tf.rightView = self.sendBtn
        tf.rightViewMode = UITextFieldViewMode.always
        
        tf.font = FontSize16
        tf.placeholder = "请输入手机验证码"
        tf.textColor = UIColor.black

        tf.layer.cornerRadius = 5
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 0.5
        
        tf.addTopBar()
        tf.keyboardType = UIKeyboardType.decimalPad
        
        return tf
    }()
    lazy var sendBtn:UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle("发送验证码", for: UIControlState.normal)
        btn.titleLabel?.font = FontSize14
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(sendAction), for: UIControlEvents.touchUpInside)
        btn.frame = CGRect(x: 0, y: 0, width: 80, height: 44)
        return btn
    }()
    
    lazy var loginBtn:UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle("登录", for: UIControlState.normal)
        btn.titleLabel?.font = FontSize16
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(loginAction), for: UIControlEvents.touchUpInside)
        
        btn.backgroundColor = UIColor.black
        btn.layer.cornerRadius = 5
        
        return btn
    }()

}

extension PNLoginView {
    @objc func sendAction() {
        if let block = sendCodeBlock {
            block()
        }
    }
    @objc func loginAction() {
        if let block = loginBlock {
            block()
        }
    }
}
