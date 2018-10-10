//
//  PNPaopaoView.swift
//  PlacesNear
//
//  Created by apple on 2018/10/9.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit
import MapKit
class PNPaopaoView: UIView {

    var placeModel:PNPlaceModel = PNPlaceModel()
    
    var isOpen:Bool = false
    
    lazy var nameLb:UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.white
        lb.font = FontSize12
        lb.text = "万达广场"
        
        return lb
    }()
    
    lazy var phoneLb:UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.white
        lb.font = FontSize12
        lb.text = "TEL:15860763896"
        
        return lb
    }()
    
    lazy var seeLineLb:UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.white
        lb.font = FontSize12
        lb.text = "路线导航>>"
        let tap = UITapGestureRecognizer(target: self, action: #selector(navigationAction))
        lb.addGestureRecognizer(tap)
        lb.isUserInteractionEnabled = true
        return lb
    }()
    
    lazy var openBtn:UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(UIImage(named: "arrows_up"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(clickPaopaoViewAction), for: UIControlEvents.touchUpInside)
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.clear
        self.frame = CGRect(x: 0, y: 0, width: 120, height: 5 * 3 + 14 * 1)
        
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        self.addSubview(nameLb)
        self.addSubview(openBtn)
        self.addSubview(phoneLb)
        self.addSubview(seeLineLb)
        
        nameLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
        }
        openBtn.snp.makeConstraints { (make) in
            make.left.equalTo(nameLb.snp.right).offset(5)
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        phoneLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(nameLb.snp.bottom).offset(5)
        }
        seeLineLb.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(phoneLb.snp.bottom).offset(5)
        }
        
    }
    override func draw(_ rect: CGRect) {
        
         guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setStrokeColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor)
        context.setFillColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor)

        context.setLineWidth(1)
        
        let radius:CGFloat = 5.0
        let allowsH:CGFloat = 5.0
        
        context.move(to: CGPoint(x: radius + 0.5, y: 0.5))
        context.addLine(to: CGPoint(x: rect.size.width - radius - 0.5, y: 0.5))
        
        context.addArc(center: CGPoint(x: rect.size.width - radius - 0.5, y: radius + 0.5), radius: radius, startAngle: CGFloat(-Double.pi/2), endAngle: 0, clockwise: false)
        
        context.addLine(to: CGPoint(x: rect.size.width - 0.5, y: rect.size.height - allowsH - radius - 0.5))
        
        context.addArc(center: CGPoint(x: rect.size.width - radius - 0.5, y: rect.size.height - allowsH - radius - 0.5), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: false)
        
        context.addLine(to: CGPoint(x: rect.size.width / 2 + allowsH / 2, y: rect.size.height - allowsH - 0.5))
        
        context.addLine(to: CGPoint(x: rect.size.width / 2, y: rect.size.height - 0.5))
        
        context.addLine(to: CGPoint(x: rect.size.width / 2 - allowsH / 2, y: rect.size.height - allowsH - 0.5))
        
        context.addLine(to: CGPoint(x: radius + 0.5, y: rect.size.height - allowsH - 0.5))
        
        context.addArc(center: CGPoint(x: radius + 0.5, y: rect.size.height - allowsH - radius - 0.5), radius: radius, startAngle: CGFloat(Float(Double.pi / 2)), endAngle: CGFloat(Double.pi), clockwise: false)
        
        context.addLine(to: CGPoint(x: 0.5, y: radius + 0.5))
        
        context.addArc(center: CGPoint(x: radius + 0.5, y: radius + 0.5), radius: radius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi / 2 * 3), clockwise: false)
        
        // 必和路径
//        context.strokePath()
        
        context.drawPath(using: .fillStroke)
    }
}
extension PNPaopaoView {
    @objc func clickPaopaoViewAction()  {
        if isOpen {
            UIView.animate(withDuration: 0.3) {
                self.frame = CGRect(x: 0, y: -38, width: 120, height: 5 * 5 + 14 * 3)
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                self.frame = CGRect(x: 0, y: 0, width: 120, height: 5 * 3 + 14 * 1)
            }
        }
        self.setNeedsDisplay()
        isOpen = !isOpen
    }
    @objc func navigationAction() {
        let alert = UIAlertController(title: "打开地图导航", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let startLocation = CLLocationCoordinate2D(latitude: placeModel.latitude!, longitude: placeModel.longitude!)
        let endLocation = CLLocationCoordinate2D(latitude: PNLocation.shareInstance.latitude!, longitude: PNLocation.shareInstance.longitude!)
        
        let action = UIAlertAction(title: "苹果地图", style: UIAlertActionStyle.default) { (action) in
            let currentLocation = MKMapItem(placemark: MKPlacemark(coordinate: startLocation, addressDictionary: nil))
            currentLocation.name = "我的位置"
            let toLocation = MKMapItem(placemark: MKPlacemark(coordinate: endLocation, addressDictionary: nil))
            toLocation.name = self.placeModel.name
            MKMapItem.openMaps(with: [currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsShowsTrafficKey: NSNumber(value: true)])
            
        }
        alert.addAction(action)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelAction)
        
        UIViewController.currentViewController()?.present(alert, animated: true, completion: nil)
    }

}
