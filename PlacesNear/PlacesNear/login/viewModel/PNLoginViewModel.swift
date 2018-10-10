//
//  PNLoginViewModel.swift
//  PlacesNear
//
//  Created by zsx on 2018/10/10.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit
import HandyJSON

class PNLoginViewModel: NSObject {
    var loginBlock:(() -> ())?
    
    var loginModel:PNLoginModel = PNLoginModel()
    
    func login(name:String) {
        SXRequest.login(params: name) { (res) in
            if res.code == 1 {
                self.loginModel = JSONDeserializer<PNLoginModel>.deserializeFrom(dict: res.data as? [String:Any])!
     
                if let block = self.loginBlock {
                    block()
                }
            }else{
                PNHud.shareInstance.showHud(message: res.message!, delay: 1.5, dismissBlock: nil)
            }
        }
    }
}
