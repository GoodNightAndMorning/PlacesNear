//
//  PNPublishLoationViewController.swift
//  PlacesNear
//
//  Created by zsx on 2018/10/9.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNPublishLoationViewController: SZViewController {

    var selectLocationBlock:((Double, Double) -> ())?
    
    
    var mapView:PNMapView = PNMapView()
    
    lazy var locationIcon:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "location_icon")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "选择位置"
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "选择", style: UIBarButtonItemStyle.plain, target: self, action: #selector(selectAction))
        
        initUi()
    }
    @objc func selectAction() {
        if let block = selectLocationBlock {
            block(mapView.mapView.region.center.latitude, mapView.mapView.region.center.longitude)
        }
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension PNPublishLoationViewController {
    func initUi() {
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(locationIcon)
        locationIcon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.snp.centerY)
        }
    }
}
