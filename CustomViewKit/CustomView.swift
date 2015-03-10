//
//  CustomView.swift
//  Sights
//
//  Created by Max Beizer on 3/9/15.
//  Copyright (c) 2015 Max Beizer. All rights reserved.
//

import QuartzCore
import UIKit

@IBDesignable
class CustomView: UIView {
    var backgroundRingLayer: CAShapeLayer! = nil
    var ringLayer: CAShapeLayer! = nil
   
    @IBInspectable var lineWidth: CGFloat = 10.0 {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable var rating: CGFloat = 0.7
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if backgroundRingLayer == nil {
            backgroundRingLayer = CAShapeLayer()
            layer.addSublayer(backgroundRingLayer)
            
            let rect = CGRectInset(bounds, lineWidth / 2.0, lineWidth / 2.0)
            let path = UIBezierPath(ovalInRect: rect)
            
            backgroundRingLayer.path = path.CGPath
            backgroundRingLayer.fillColor = nil
            backgroundRingLayer.lineWidth = lineWidth
            backgroundRingLayer.strokeColor = UIColor(white: 0.5, alpha: 0.3).CGColor
        }
        
        backgroundRingLayer.frame = bounds
        
        if ringLayer == nil {
            ringLayer = CAShapeLayer()
            
            let innerRect = CGRectInset(bounds, lineWidth / 2.0, lineWidth / 2.0)
            let innerPath = UIBezierPath(ovalInRect: innerRect)
            
            ringLayer.path = innerPath.CGPath
            ringLayer.fillColor = nil
            ringLayer.lineWidth = lineWidth
            ringLayer.strokeColor = UIColor.blueColor().CGColor
            ringLayer.anchorPoint = CGPointMake(0.5, 0.5)
            ringLayer.transform = CATransform3DRotate(ringLayer.transform, CGFloat(-M_PI/2.0), 0.0, 0.0, 1.0)
            layer.addSublayer(ringLayer)
        }
        
        ringLayer.frame = bounds
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        if ringLayer != nil {
            ringLayer.strokeEnd = rating
            
            var strokeColor: UIColor
            switch rating {
            case let r where r >= 0.75:
                strokeColor = UIColor(hue: 112.0/360.0, saturation: 0.39, brightness: 0.85, alpha: 1.0)
            case let r where r >= 0.5:
                strokeColor = UIColor(hue: 208.0/360.0, saturation: 0.51, brightness: 0.75, alpha: 1.0)
            case let r where r >= 0.25:
                strokeColor = UIColor(hue: 40.0/360.0, saturation: 0.39, brightness: 0.85, alpha: 1.0)
            default:
                strokeColor = UIColor(hue: 359.0/360.0, saturation: 0.48, brightness: 0.63, alpha: 1.0)
            }
            
            ringLayer.strokeColor = strokeColor.CGColor
        }
    }
    
}
