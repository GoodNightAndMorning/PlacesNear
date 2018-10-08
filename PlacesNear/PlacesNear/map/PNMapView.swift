//
//  PNMapView.swift
//  PlacesNear
//
//  Created by apple on 2018/10/8.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNMapView: UIView {

    var mapView:BMKMapView!
    var locationService:BMKLocationService!
    
    var userLocation:BMKUserLocation = BMKUserLocation()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        initMapView()
        initLocationService()
    }
    func initMapView()  {
        mapView = BMKMapView(frame: self.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = BMKUserTrackingModeNone
        mapView.mapType = UInt(BMKMapTypeStandard)
        mapView.zoomLevel = 17
        
        let displayParam = BMKLocationViewDisplayParam()
        displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
        displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
        
        displayParam.isAccuracyCircleShow = false;//经度圈是否显示
        //这里替换自己的图标路径，必须把图片放到百度地图SDK的Resources/mapapi.bundle/images 下面
        //还有一种方法就是获取到_locationView之后直接设置图片
        displayParam.locationViewImgName = "bnavi_icon_location_fixed";
        
        mapView.updateLocationView(with: displayParam)
        
        self.addSubview(mapView)
    }
    func initLocationService() {
        locationService = BMKLocationService()
        locationService.delegate = self
        locationService.startUserLocationService()
    }
}
extension PNMapView:BMKLocationServiceDelegate {
    func didUpdate(_ userLocation: BMKUserLocation!) {
        self.userLocation = userLocation
        mapView.updateLocationData(self.userLocation)
        
        mapView.setCenter(self.userLocation.location.coordinate, animated: true)
    }
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        self.userLocation = userLocation
        
        mapView.updateLocationData(self.userLocation)
    }
}
