//
//  PNDistanceRulerView.swift
//  PlacesNear
//
//  Created by apple on 2018/9/28.
//  Copyright © 2018年 zsx. All rights reserved.
//

import UIKit

class PNDistanceRulerView: UIView {

    var limbArr:[String]?
    
    var arrows:PNRulerArrows = PNRulerArrows()
    
    var distanceRulerBlock:((_ :Float) -> ())?
    
    var arrowsY:CGFloat = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(arrowsPanAction(pan:)))
        self.arrows.addGestureRecognizer(pan)
    }
    override func layoutSubviews() {
        self.addSubview(arrows)
        self.arrows.frame = CGRect(x: (self.frame.size.width - 35 ) / 2 + 16, y: 3, width: 25, height: 14)
    }
    public func setLimbArr(limbArr:[String]) {
        self.limbArr = limbArr
        
        self.setNeedsDisplay()
    }
    @objc func arrowsPanAction(pan:UIPanGestureRecognizer) {
        if (pan.state == UIGestureRecognizerState.changed) {
            let point = pan.translation(in: self)
            
            self.arrows.frame = CGRect(x: self.arrows.frame.origin.x, y: point.y + self.arrowsY, width: self.arrows.frame.size.width, height: self.arrows.frame.size.height)
            
            if self.arrows.frame.origin.y < 10 - self.arrows.frame.size.height / 2 {
                self.arrows.frame = CGRect(x: self.arrows.frame.origin.x, y: 10 - self.arrows.frame.size.height / 2, width: self.arrows.frame.size.width, height: self.arrows.frame.size.height)
            }
            if self.arrows.frame.origin.y > self.frame.size.height - 10 - self.arrows.frame.size.height / 2 {
                self.arrows.frame = CGRect(x: self.arrows.frame.origin.x, y:self.frame.size.height - 10 - self.arrows.frame.size.height / 2, width: self.arrows.frame.size.width, height: self.arrows.frame.size.height)
            }
            
        }else if pan.state == UIGestureRecognizerState.began {
            
            self.arrowsY = self.arrows.frame.origin.y
            
        }else if pan.state == UIGestureRecognizerState.ended {
            if let block = self.distanceRulerBlock {
                
                let y = self.arrows.frame.origin.y + self.arrows.frame.size.height / 2
                
                let bigLimb:CGFloat = (self.frame.size.height - 20) / CGFloat(limbArr!.count - 1)
                
                let i = Int(floor((y - 10) / bigLimb))
                
                let offset = y - 10 - bigLimb * CGFloat(i)
     
                var distanc:Float = 0
                if i == (self.limbArr?.count)! - 1 {
                    distanc = Float((self.limbArr?.last)!)!
                }else{
                    distanc = Float(self.limbArr![i])! + (Float(self.limbArr![i+1])! - Float(self.limbArr![i])!) * Float(offset) / Float(bigLimb)
                }
                
                block(distanc)
            }
        }
    }
    override func draw(_ rect: CGRect) {
        let ctx:CGContext = UIGraphicsGetCurrentContext()!
        
        UIColor.black.set()
        
        guard let array = limbArr else { return }
        
        let count = array.count - 1
        
        let bigLimb:CGFloat = (self.frame.size.height - 20) / CGFloat(count)
        
        let smallLimb:CGFloat = bigLimb / 5.0
        
        ctx.setLineWidth(2.0)
        ctx.move(to: CGPoint(x: 15, y: 10))
        ctx.addLine(to: CGPoint(x: self.frame.size.width - 20, y: 10))
        
        ctx.move(to: CGPoint(x: 15, y: self.frame.size.height - 10))
        ctx.addLine(to: CGPoint(x: self.frame.size.width - 20, y: self.frame.size.height - 10))
        
        ctx.move(to: CGPoint(x: (self.frame.size.width - 35 ) / 2 + 15, y: 10))
        ctx.addLine(to: CGPoint(x: (self.frame.size.width - 35) / 2 + 15, y: self.frame.size.height - 10))
        
        for i in 0..<count {
            for j in 0..<5 {
                if j == 0 {
                    ctx.setLineWidth(2.0)
                    
                    ctx.move(to: CGPoint(x: 15, y: bigLimb * CGFloat(i) + 10))
                    ctx.addLine(to: CGPoint(x: (self.frame.size.width - 35 ) / 2 + 15, y: bigLimb * CGFloat(i) + 10))
                }else{
                    ctx.setLineWidth(1.0)
                    
                    ctx.move(to: CGPoint(x: (self.frame.size.width - 35) / 4 + 15, y: bigLimb * CGFloat(i) + smallLimb * CGFloat(j) + 10))
                    ctx.addLine(to: CGPoint(x: (self.frame.size.width - 35) / 2 + 15, y: bigLimb * CGFloat(i) + smallLimb * CGFloat(j) + 10))
                }
            }
            
            
            let str = array[i]
            
            (str as NSString).draw(at: CGPoint(x: 1, y: bigLimb * CGFloat(i) + 10), withAttributes: [NSAttributedStringKey.font : FontSize14, NSAttributedStringKey.foregroundColor:UIColor.black])
        }
        
        let str = array.last
        
        (str as! NSString).draw(at: CGPoint(x: 1, y: bigLimb * CGFloat(array.count - 1) + 10 - 5), withAttributes: [NSAttributedStringKey.font : FontSize14, NSAttributedStringKey.foregroundColor:UIColor.black])
        
        ctx.strokePath()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class PNRulerArrows: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        let ctx:CGContext = UIGraphicsGetCurrentContext()!
//        ctx.setFillColor(UIColor.black.cgColor)
        ctx.setFillColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        ctx.setLineWidth(1.0)
        ctx.move(to: CGPoint(x: 0.5, y: rect.size.height / 2))
        ctx.addLine(to: CGPoint(x: rect.size.height / 2, y: 0.5))
        ctx.addLine(to: CGPoint(x: rect.size.width - 0.5, y: 0.5))
        ctx.addLine(to: CGPoint(x: rect.size.width - 0.5, y: rect.size.height - 0.5))
        ctx.addLine(to: CGPoint(x: rect.size.height / 2, y: rect.size.height - 0.5))
        ctx.addLine(to: CGPoint(x: 0.5, y: rect.size.height / 2))
        
//        ctx.strokePath()
        ctx.drawPath(using: .fill)
    }
}
