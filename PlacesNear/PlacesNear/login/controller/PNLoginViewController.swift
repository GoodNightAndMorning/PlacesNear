//
//  PNLoginViewController.swift
//  PlacesNear
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNLoginViewController: SZViewController {

    let allViews:PNLoginView = PNLoginView()
    
    let viewModel:PNLoginViewModel = PNLoginViewModel()
    
    var seconds:Int = 60
    
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "登录"
        
        initUi()
        initAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension PNLoginViewController {
    func initAction() {
        allViews.sendCodeBlock = {
            //TODO:发送验证码
            guard let phone = self.allViews.phoneTf.text else {
                PNHud.shareInstance.showHud(message: "请输入手机号码", delay: 1.5, dismissBlock: nil)
                return
            }
            if phone.count == 0 {
                PNHud.shareInstance.showHud(message: "请输入手机号码", delay: 1.5, dismissBlock: nil)
                return
            }
            if !(phone.isPhoneNumber()) {
                PNHud.shareInstance.showHud(message: "请输入正确手机号码", delay: 1.5, dismissBlock: nil)
                return
            }
            
//            SMSSDK.getVerificationCode(by: SMSGetCodeMethod.SMS, phoneNumber: phone, zone: "86", result: { (error) in
//                guard error != nil else {
//
//                    self.seconds = 60
//
//                    self.allViews.sendBtn.isEnabled = false
//                    self.allViews.sendBtn.setTitle("\(self.seconds)s", for: UIControlState.normal)
//
//                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDownAction), userInfo: nil, repeats: true)
//
//                    return
//                }
//                PNHud.shareInstance.showHud(message: "发送验证码失败", delay: 1.5, dismissBlock: nil)
//            })
        }
        allViews.loginBlock = {
            //TODO:登录
            if self.allViews.codeTf.text?.count == 0 {
                PNHud.shareInstance.showHud(message: "请输入验证码", delay: 1.5, dismissBlock: nil)
                return
            }
            
            
//            SMSSDK.commitVerificationCode(self.allViews.codeTf.text, phoneNumber: self.allViews.phoneTf.text, zone: "86", result: { (error) in
//                if error == nil {
//                    //TODO:验证码验证成功
//                    self.navigationController?.popViewController(animated: true)
//                }else{
//                    PNHud.shareInstance.showHud(message: "验证码错误", delay: 1.5, dismissBlock: nil)
//                }
//            })
            
            self.viewModel.login(name: self.allViews.phoneTf.text!)
            self.viewModel.loginBlock = {
                PNUser.shareInstance.id = self.viewModel.loginModel.id
                PNUser.shareInstance.name = self.viewModel.loginModel.name
                PNUser.shareInstance.nickName = self.viewModel.loginModel.nickName
                PNUser.shareInstance.token = self.viewModel.loginModel.token
                
                PNUser.shareInstance.saveUserToUserDefaults()
                
                PNHud.shareInstance.showHud(message: "登录成功", delay: 1, dismissBlock: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    @objc func countDownAction() {
        self.seconds = self.seconds - 1
        self.allViews.sendBtn.setTitle("\(self.seconds)s", for: UIControlState.normal)
        if self.seconds == 0 {
            timer.invalidate()
            
            self.allViews.sendBtn.isEnabled = true
            self.allViews.sendBtn.setTitle("发送验证码", for: UIControlState.normal)
        }
    }
}
extension PNLoginViewController {
    func initUi() {
        self.view.addSubview(allViews.phoneTf)
        self.view.addSubview(allViews.codeTf)
        self.view.addSubview(allViews.loginBtn)
        
        allViews.phoneTf.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.equalToSuperview().offset(120)
            make.height.equalTo(44)
        }
        allViews.codeTf.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.equalTo(allViews.phoneTf.snp.bottom).offset(20)
            make.height.equalTo(44)
        }
        allViews.loginBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.equalTo(allViews.codeTf.snp.bottom).offset(40)
            make.height.equalTo(44)
        }
    }
}
