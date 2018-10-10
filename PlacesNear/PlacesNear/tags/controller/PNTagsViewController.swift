//
//  PNTagsViewController.swift
//  PlacesNear
//
//  Created by apple on 2018/9/29.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

let PNTagsTableViewCellIdentifier = "PNTagsTableViewCell"
class PNTagsViewController: SZViewController {

    let viewModel:PNTagsViewModel = PNTagsViewModel()
    
    lazy var pageParams:PNPageParams = {
        let params = PNPageParams()
        params.pageSize = 10
        return params
    }()
    
    var selectTagBlock:((PNGetTagsListModel) -> ())?
    
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
        
        mainTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.getTagsList(isRefresh: true)
        })
        mainTableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.getTagsList(isRefresh: false)
        })
        
        viewModel.getTagsListBlock = {
            isAllLoad in
            
            self.mainTableView.mj_header.endRefreshing()
            self.mainTableView.mj_footer.endRefreshing()
            
            self.mainTableView.mj_footer.isHidden = isAllLoad
            
            self.mainTableView.reloadData()
        }
        getTagsList(isRefresh: true)
    }
    func getTagsList(isRefresh:Bool) {
        if isRefresh {
            pageParams.pageNum = 1
        }else{
            pageParams.pageNum = pageParams.pageNum! + 1
        }
        
        viewModel.getTagsList(params: pageParams)
    }
}
extension PNTagsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tagsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PNTagsTableViewCell = tableView.dequeueReusableCell(withIdentifier: PNTagsTableViewCellIdentifier) as! PNTagsTableViewCell
        cell.setTags(tagName: viewModel.tagsArr[indexPath.row].name!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let block = selectTagBlock {
            block(viewModel.tagsArr[indexPath.row])
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
