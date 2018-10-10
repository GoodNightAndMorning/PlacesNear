//
//  UIViewControllerExtension.swift
//  PlacesNear
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 zsx. All rights reserved.
//

import Foundation

extension UIViewController {
    public class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
