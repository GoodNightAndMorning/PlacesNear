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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    public func setLimbArr(limbArr:[String]) {
        self.limbArr = limbArr
        
        self.setNeedsDisplay()
    }
    override func draw(_ rect: CGRect) {
        let ctx:CGContext = UIGraphicsGetCurrentContext()!
        
        UIColor.black.set()
        
        guard let array = limbArr else { return }
        
        let count = array.count
        
        let bigLimb:CGFloat = self.frame.size.height / CGFloat(count)
        
        let smallLimb:CGFloat = bigLimb / 5.0
        
        ctx.setLineWidth(2.0)
        ctx.move(to: CGPoint(x: 10, y: 0))
        ctx.addLine(to: CGPoint(x: self.frame.size.width, y: 0))
        
        ctx.move(to: CGPoint(x: 10, y: self.frame.size.height))
        ctx.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        
        ctx.move(to: CGPoint(x: (self.frame.size.width - 10 ) / 2 + 10, y: 0))
        ctx.addLine(to: CGPoint(x: (self.frame.size.width - 10 ) / 2 + 10, y: self.frame.size.height))
        
        for i in 0..<count {
            for j in 0..<5 {
                if j == 0 {
                    ctx.setLineWidth(2.0)
                    
                    ctx.move(to: CGPoint(x: 10, y: bigLimb * CGFloat(i)))
                    ctx.addLine(to: CGPoint(x: (self.frame.size.width - 10 ) / 2 + 10, y: bigLimb * CGFloat(i)))
                }else{
                    ctx.setLineWidth(1.0)
                    
                    ctx.move(to: CGPoint(x: (self.frame.size.width - 10) / 4 + 10, y: bigLimb * CGFloat(i) + smallLimb * CGFloat(j)))
                    ctx.addLine(to: CGPoint(x: (self.frame.size.width - 10) / 2 + 10, y: bigLimb * CGFloat(i) + smallLimb * CGFloat(j)))
                }
            }
            
            
            let str = array[i]
            
//            (str as NSString).draw(at: CGPoint(x: 1, y: bigLimb * CGFloat(i)), withAttributes: [NSAttributedStringKey : Any]?)
        }
        
        ctx.strokePath()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
