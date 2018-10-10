//
//  SXRequest.swift
//  SwiftBase
//
//  Created by 刘章郁 on 2018/9/5.
//  Copyright © 2018 zsx. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

public class SXRequest: NSObject {
    public typealias SuccessBlock = (SXModel) -> ()
    
    /// GET方法
    ///
    /// - Parameters:
    ///   - url: url
    ///   - params: params
    ///   - successBlock: successBlock
    static private func getRequest(url:String, params:[String:Any], successBlock:@escaping SuccessBlock) {
        
        request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseString(completionHandler: { (response) in
            print("==============================================")
            print("//url:")
            print(url)
            print("//参数:")
            print(params)
            print("----------------------------------->>>>")
            
            if let res = JSONDeserializer<SXModel>.deserializeFrom(json: response.value){
                successBlock(res)
            } else {
                PNHud.shareInstance.showHud(message: "请求失败", delay: 1.5, dismissBlock: nil)
            }
            print("==============================================")
        })
    }
    /// GET方法
    ///
    /// - Parameters:
    ///   - url: url
    ///   - params: params
    ///   - successBlock: successBlock
    static private func postRequest(url:String, params:[String:Any], successBlock:@escaping SuccessBlock) {

        request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseString(completionHandler: { (response) in
            print("==============================================")
            print("//url:")
            print(url)
            print("//参数:")
            print(params)
            print("----------------------------------->>>>")
            
            if let res = JSONDeserializer<SXModel>.deserializeFrom(json: response.value){
                successBlock(res)
            } else {
                PNHud.shareInstance.showHud(message: "请求失败", delay: 1.5, dismissBlock: nil)
            }
            print("==============================================")
        })
    }

    /// 模型转字典
    ///
    /// - Parameter m: 模型
    /// - Returns: 字典
    static private func convertModelToDic(m:NSObject) -> [String:Any] {
        var p:[String:Any] = [String:Any]()
        let paramsMirror = Mirror(reflecting: m)
        for eachItem in paramsMirror.children {
            let (key,value) = eachItem
            p[key!] = value
        }
        return p
    }
}
// MARK: - 接口请求
extension SXRequest {
    
    /// 登录请求
    ///
    /// - Parameters:
    ///   - params: 手机号码
    ///   - successBlock: block
    public static func login(params:String, successBlock:@escaping SuccessBlock) {
        
        postRequest(url: DomainName + "user/login", params: ["userName": params], successBlock: successBlock)
    }
    public static func getTagsList(params:NSObject, successBlock:@escaping SuccessBlock){
        let p:[String:Any] = convertModelToDic(m: params)
        getRequest(url: DomainName + "places/getTagsList", params: p, successBlock: successBlock)
    }
//    public static func getSystemMsg(params:NSObject, successBlock:@escaping SuccessBlock) {
//
//        let p:[String:Any] = convertModelToDic(m: params)
//        getRequest(url: SAccountUrl + "api/Push/GetSystemMsg", params: p, successBlock: successBlock)
//    }
}
