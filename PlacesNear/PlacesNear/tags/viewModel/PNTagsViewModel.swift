//
//  PNTagsViewModel.swift
//  PlacesNear
//
//  Created by zsx on 2018/10/10.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit
import HandyJSON
class PNTagsViewModel: NSObject {
    
    var getTagsListBlock:((_ isAllLoad:Bool) -> ())?
    
    var tagsArr:[PNGetTagsListModel] = [PNGetTagsListModel]()
    
    func getTagsList(params:PNPageParams) {
        SXRequest.getTagsList(params: params) { (res) in
            if res.code == 1 {
                
                let data = JSONDeserializer<PNPagesModel<PNGetTagsListModel>>.deserializeFrom(dict: res.data as? [String:Any])
                if let list = data?.list {
                    if params.pageNum == 1 {
                        self.tagsArr = list
                    }else{
                        self.tagsArr.append(contentsOf: list)
                    }
                }
                if let block = self.getTagsListBlock {
                    block(data?.total == self.tagsArr.count)
                }
            }else{
                PNHud.shareInstance.showHud(message: res.message!, delay: 1, dismissBlock: nil)
            }
        }
    }
}
