//
//  PNUser.swift
//  PlacesNear
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNUser: NSObject {
    static let shareInstance = PNUser()
    
    var id:String?
    var name:String?
    var nickName:String?
    var token:String?
    
    func setUserFromUserDefaults() {
        guard let dic = UserDefaults.standard.dictionary(forKey: "UserInfoKey") else {
            return
        }
        id = dic["id"] as? String;
        name = dic["name"] as? String;
        nickName = dic["nickName"] as? String
        token = dic["token"] as? String
    }
    func saveUserToUserDefaults() {
        var dic:[String:String] = [String:String]()
        dic["id"] = id
        dic["name"] = name
        dic["nickName"] = name
        dic["token"] = token
        UserDefaults.standard.set(dic, forKey: "UserInfoKey")
        UserDefaults.standard.synchronize()
    }
    func clear() {
        id = nil
        name = nil
        nickName = nil
        token = nil
        
        UserDefaults.standard.set(nil, forKey: "UserInfoKey")
        UserDefaults.standard.synchronize()
    }
}
