//
//  CircleView.swift
//  Timer
//
//  Created by Vladimir Cherednichenko on 25.08.17.
//  Copyright © 2017 Vladimir Cherednichenko. All rights reserved.
//

import Foundation
import UIKit

class CircleView:UIView,CAAnimationDelegate {
    private var timeCircleLayer = CAShapeLayer()
    private var transformRotate = CATransform3D()
    private var progress:Double = 1.0
    private func getCirclePath(_ centerOfPath:CGPoint, radius:CGFloat, clockwise:Bool, startAngle:CGFloat, endAngle:CGFloat)
    
        ->CGPath
    {
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x:centerOfPath.x,y:centerOfPath.y), radius: radius, startAngle:startAngle, endAngle:endAngle, clockwise: clockwise)
        return path
    }
    
    
    
    public func setProgress(procent:Double)
    {
            self.progress = procent
            let radius:CGFloat = self.bounds.width / 2.5
            self.timeCircleLayer.path = getCirclePath((CGPoint(x:radius,y:radius)), radius: radius, clockwise: false, startAngle: 0, endAngle: (CGFloat(Double.pi*2*procent)))
            self.timeCircleLayer.strokeColor = UIColor.init(red: 209/255, green: 52/255, blue: 88/255, alpha: 1).cgColor
            self.timeCircleLayer.lineWidth = 10
            self.timeCircleLayer.fillColor = UIColor.clear.cgColor
            self.timeCircleLayer.borderWidth = 0
            timeCircleLayer.frame = CGRect(x: self.center.x - radius, y: self.center.y - radius, width: radius*2, height: radius*2)
        
    }
    
    
    
    override func draw(_ rect: CGRect) {
        
        
        self.backgroundColor = UIColor.clear
        let backGroundCircleLayer = CAShapeLayer()
        backGroundCircleLayer.path = getCirclePath(self.center, radius: self.bounds.width / 2.5, clockwise: true, startAngle:  0, endAngle: (CGFloat(Double.pi*2)))
        backGroundCircleLayer.position = CGPoint(x:0,y:0)
        backGroundCircleLayer.fillColor = UIColor.clear.cgColor
        backGroundCircleLayer.backgroundColor = UIColor.clear.cgColor
        backGroundCircleLayer.borderWidth = 0
        backGroundCircleLayer.strokeColor = UIColor.init(red: 49/255, green: 51/255, blue: 103/255, alpha: 1).cgColor
        backGroundCircleLayer.lineWidth = 10
        
        self.transformRotate = timeCircleLayer.transform
        self.transformRotate = CATransform3DRotate(transformRotate, (CGFloat(Double.pi / 2)), 0, 0, -1)
        timeCircleLayer.transform = self.transformRotate
        
        self.layer.addSublayer(backGroundCircleLayer)
        self.layer.addSublayer(timeCircleLayer)
        self.setProgress(procent: self.progress)
    }
}
