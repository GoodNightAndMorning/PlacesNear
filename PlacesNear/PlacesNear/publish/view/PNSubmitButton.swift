//
//  PNSubmitButton.swift
//  PlacesNear
//
//  Created by apple on 2018/9/29.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNSubmitButton: UIView {

    enum SubmitState {
        case success
        case failuer
    }
    
    var clickBtnBlock:(() -> ())?
    var finishBlock:(() -> ())?
    func endAnimation(state:SubmitState) {
        self.state = state
        self.progressLayer.removeAllAnimations()
        self.progressLayer.removeFromSuperlayer()
        self.largenAniAction()
    }
    
    var state:SubmitState?
    lazy var btnView:UIView = {
        let view = UIView()
        view.frame = self.bounds
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = self.frame.size.height / 2
        return view
    }()

    var circleLayer:CAShapeLayer = CAShapeLayer()
    
    lazy var progressLayer:CAShapeLayer = {
        
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinBevel
        layer.lineWidth = 4.0
        layer.strokeEnd = 0.0
        
        return layer
    }()
    
    lazy var submitLb:UILabel = {
        let lb = UILabel()
        lb.text = "提交"
        lb.textColor = UIColor.white
        lb.font = FontSize16
        
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickBtnAction))
        
        self.addGestureRecognizer(tap)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PNSubmitButton {
    @objc func clickBtnAction() {
        
        self.isUserInteractionEnabled = false
        
        let shrinkAni = CABasicAnimation(keyPath: "bounds")
        shrinkAni.fromValue = self.bounds
        shrinkAni.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: self.bounds.size.height, height: self.bounds.size.height))
        shrinkAni.isRemovedOnCompletion = false
        shrinkAni.fillMode = kCAFillModeForwards;
        shrinkAni.duration = 1.0
        
        btnView.layer.add(shrinkAni, forKey: "shrinkAni")
        
        UIView.animate(withDuration: 1.0, animations: {
            self.submitLb.alpha = 0
            self.btnView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.btnView.layer.borderColor = UIColor.gray.cgColor
            self.btnView.layer.borderWidth = 2.0
        }) { (isFinish) in
            self.circleAniAction()
            if let block = self.clickBtnBlock {
                block()
            }
        }
    }
    func largenAniAction() {
        
        let largenAni = CABasicAnimation(keyPath: "bounds")
        largenAni.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: self.bounds.size.height, height: self.bounds.size.height))
        largenAni.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        largenAni.isRemovedOnCompletion = false
        largenAni.fillMode = kCAFillModeForwards;
        largenAni.duration = 1.0
        
        btnView.layer.add(largenAni, forKey: "largenAni")
        
        UIView.animate(withDuration: 1.0, animations: {
            if self.state == SubmitState.success {
                self.submitLb.text = "谢谢您的发布!"
            }else{
                self.submitLb.text = "提交失败，请重新提交"
            }
            
            self.submitLb.alpha = 1.0
            self.btnView.backgroundColor = UIColor.black
            self.btnView.layer.borderColor = UIColor.black.cgColor
            self.btnView.layer.borderWidth = 0.0
        }) { (isFinish) in
            self.isUserInteractionEnabled = self.state == SubmitState.failuer
            if let block = self.finishBlock {
                block()
            }
        }
    }
    func circleAniAction() {
        let center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        
        let progressCircle = UIBezierPath()
        progressCircle.addArc(withCenter: center, radius: self.bounds.size.height / 2, startAngle: -CGFloat(Double.pi) / 2, endAngle: CGFloat(Double.pi) / 2 * 3, clockwise: true)
        
        progressLayer.path = progressCircle.cgPath
        
        self.layer.addSublayer(progressLayer)
        
        
        
        let endAni = CAKeyframeAnimation(keyPath: "strokeEnd")
        endAni.values = [NSNumber(value: 0.0),NSNumber(value: 1.0),NSNumber(value: 1.0)]
//        progressLayer.add(endAni, forKey: "strokeEndAnimation")
        
        let startAni = CAKeyframeAnimation(keyPath: "strokeStart")
        startAni.values = [NSNumber(value: 0.0),NSNumber(value: 0.0),NSNumber(value: 1.0)]
//        progressLayer.add(endAni, forKey: "strokeEndAnimation")
        
        
        
        let group = CAAnimationGroup()
        group.animations = [endAni, startAni]
        group.duration = 3
        group.fillMode = kCAFillModeForwards
        group.isRemovedOnCompletion = false
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        group.repeatCount = 10000000

        progressLayer.add(group, forKey: "circleAnimation")

    }
}
extension PNSubmitButton {
    override func layoutSubviews() {
        
        self.addSubview(btnView)
        
        self.addSubview(submitLb)
        submitLb.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
