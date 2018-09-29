//
//  PNTagsViewController.swift
//  PlacesNear
//
//  Created by apple on 2018/9/29.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

let PNTagsTableViewCellIdentifier = "PNTagsTableViewCell"
class PNTagsViewController: UIViewController {

    var selectTagBlock:((_ :String) -> ())?
    
    let tags:[String] = ["公交站","地铁站","电动车维修店","四儿子店","商业广场","垃圾回收站","医院","诊所","银行","派出所","ATM"]
    
    lazy var mainTableView:UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        
        tv.delegate = self
        tv.dataSource = self
        tv.rowHeight = 44
        tv.register(PNTagsTableViewCell.self, forCellReuseIdentifier: PNTagsTableViewCellIdentifier)
        
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "所有标签"
        self.view.addSubview(mainTableView)
    }
}
extension PNTagsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PNTagsTableViewCell = tableView.dequeueReusableCell(withIdentifier: PNTagsTableViewCellIdentifier) as! PNTagsTableViewCell
        cell.setTags(tagName: tags[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let block = selectTagBlock {
            block(tags[indexPath.row])
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
