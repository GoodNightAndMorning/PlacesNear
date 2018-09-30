//
//  StringExtension.swift
//  PlacesNear
//
//  Created by zsx on 2018/9/30.
//  Copyright © 2018年 zsx. All rights reserved.
//

import Foundation

extension String {
    
    /// 验证是否是手机号码
    ///
    /// - Returns: 是否是手机号码
    func isPhoneNumber() -> Bool {
        if self.count == 0 {
            return false
        }
        let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: self) == true {
            return true
        }else
        {
            return false
        }
    }
}
