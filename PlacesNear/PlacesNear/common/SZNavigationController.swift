//
//  SZNavigationController.swift
//  SwiftBase
//
//  Created by zsx on 2018/8/28.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

open class SZNavigationController: UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.white
        
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        self.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]
        
        self.navigationBar.tintColor = UIColor.black
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
