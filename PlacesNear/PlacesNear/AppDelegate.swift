//
//  AppDelegate.swift
//  PlacesNear
//
//  Created by apple on 2018/9/27.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var _mapManager:BMKMapManager!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        let vc:PNHomeViewController = PNHomeViewController()
        let navi:SZNavigationController = SZNavigationController(rootViewController: vc)
        
        self.window?.rootViewController = navi
        
        application.statusBarStyle = UIStatusBarStyle.lightContent
        
        _mapManager = BMKMapManager()
        let ret = _mapManager.start(BMKMapKey, generalDelegate: self)
        if !ret {
            print("map manager start failed!")
        }
        
        PNUser.shareInstance.setUserFromUserDefaults()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
extension AppDelegate: BMKGeneralDelegate {
    func onGetNetworkState(_ iError: Int32) {
        if 0 == iError {
            print("联网成功")
        } else {
            print("onGetNetworkState \(iError)")
        }
    }
    func onGetPermissionState(_ iError: Int32) {
        if 0 == iError {
            print("授权成功")
        } else {
            print("onGetPermissionState \(iError)")
        }
    }
}
