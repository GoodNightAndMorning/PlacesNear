//
//  PNAnimationButton.swift
//  PlacesNear
//
//  Created by apple on 2018/9/28.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNAnimationButton: UIButton {
    
    lazy var wLayer:CAShapeLayer = {
        let radius:CGFloat = 30.0

        let layer = CAShapeLayer()
        layer.lineWidth = 1
        layer.position = CGPoint(x: 30, y: 30)
        layer.path = UIBezierPath(roundedRect: CGRect(x: -30, y: -30, width: 60, height: 60), cornerRadius: radius).cgPath
        
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.animationAction()
    }
    
    @objc func animationAction() {
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = NSNumber(value: 1)
        opacityAnim.toValue = NSNumber(value: 0)
        
        let scaleAnim = CABasicAnimation(keyPath: "transform")
        scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(1.5, 1.5, 1.5))
        
        let group = CAAnimationGroup()
        group.animations = [opacityAnim, scaleAnim]
        group.duration = 1.5
        group.fillMode = kCAFillModeBoth
        group.isRemovedOnCompletion = false
        
        group.repeatCount = 10000000
        
        self.layer.addSublayer(wLayer)
        group.setValue(layer, forKey: "animatedLayer")
        wLayer.add(group, forKey: "buttonAnimation")

        
        print("animation")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
