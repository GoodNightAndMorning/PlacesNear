//
//  PNHud.swift
//  PlacesNear
//
//  Created by zsx on 2018/10/9.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNHud: UIView {

    static let shareInstance = PNHud()
    
    lazy var titleLb:UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.white
        lb.font = FontSize16
        lb.textAlignment = NSTextAlignment.center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        self.addSubview(titleLb)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showHud(message:String, delay:Double, dismissBlock:(() -> ())?) {
        titleLb.text = message
        titleLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.lessThanOrEqualTo(200)
        }
        UIApplication.shared.keyWindow?.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            self.removeFromSuperview()
            
            if let block = dismissBlock {
                block()
            }
        })
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let radius:CGFloat = 5
        
        context?.setFillColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor)
        context?.setStrokeColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor)
        
        context?.move(to: CGPoint(x: radius + 0.5, y: 0.5))
        context?.addLine(to: CGPoint(x: rect.size.width - radius - 0.5, y: 0.5))
        context?.addArc(center: CGPoint(x: rect.size.width - radius - 0.5, y: radius + 0.5), radius: radius, startAngle: -CGFloat(Double.pi / 2), endAngle: 0, clockwise: false)
        context?.addLine(to: CGPoint(x: rect.size.width - 0.5, y: rect.size.height - radius - 0.5))
        context?.addArc(center: CGPoint(x: rect.size.width - radius - 0.5, y: rect.size.height - radius - 0.5), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: false)
        context?.addLine(to: CGPoint(x: radius + 0.5, y: rect.size.height - 0.5))
        context?.addArc(center: CGPoint(x: radius + 0.5, y: rect.size.height - radius - 0.5), radius: radius, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: false)
        context?.addLine(to: CGPoint(x: 0.5, y: radius + 0.5))
        context?.addArc(center: CGPoint(x: radius + 0.5, y: radius + 0.5), radius: radius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi / 2 * 3), clockwise: false)
        
        context?.drawPath(using: CGPathDrawingMode.fillStroke)
    }
}
