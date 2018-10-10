//
//  PNPagesModel.swift
//  PlacesNear
//
//  Created by zsx on 2018/10/10.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit
import HandyJSON
class PNPagesModel<T>: HandyJSON {
    
    var total:Int?
    var pages:Int?
    var list: [T]?
    
    required init(){}
}
