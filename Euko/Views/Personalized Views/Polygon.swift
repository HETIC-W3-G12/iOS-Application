//
//  Polygon.swift
//  Euko
//
//  Created by Victor Lucas on 28/01/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

@IBDesignable class Polygon: UIView {
    
    @IBInspectable var firstPointX: CGFloat = 0
    @IBInspectable var firstPointY: CGFloat = 0
    @IBInspectable var secondPointX: CGFloat = 0.5
    @IBInspectable var secondPointY: CGFloat = 1
    @IBInspectable var thirdPointX: CGFloat = 1
    @IBInspectable var thirdPointY: CGFloat = 0
    @IBInspectable var fourthPointX: CGFloat = 1
    @IBInspectable var fourthPointY: CGFloat = 1
    
    private var gradientLayer: CAGradientLayer!
    
    @IBInspectable var topColor: UIColor = .red {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = .yellow {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var gradientStartPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var gradientStartPointY: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var gradientEndPointX: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var gradientEndPointY: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        
        aPath.move(to: CGPoint(x: self.secondPointX * rect.width, y: self.secondPointY * rect.height))
        aPath.addLine(to: CGPoint(x: self.firstPointX * rect.width, y: self.firstPointY * rect.height))
        aPath.addLine(to: CGPoint(x: self.thirdPointX * rect.width, y: self.thirdPointY * rect.height))
        aPath.addLine(to: CGPoint(x: self.fourthPointX * rect.width, y: self.fourthPointY * rect.height))
        aPath.close()
        aPath.addClip()
        
        self.backgroundColor = .clear
        let context = UIGraphicsGetCurrentContext()!
        let colors = [topColor.cgColor, bottomColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        let startPoint = CGPoint(x: self.gradientStartPointX * rect.width, y: self.gradientStartPointY * rect.height)
        let endPoint = CGPoint(x: self.gradientEndPointX * rect.width, y: self.gradientEndPointY * rect.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
}
