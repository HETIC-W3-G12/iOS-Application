//
//  ExtView.swift
//  Euko
//
//  Created by Victor Lucas on 11/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

extension UIView {
    func addDismisKeyBoardOnTouch(){
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:))))
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        //layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        layer.rasterizationScale = 1
    }
    
    func setSpecificShadow(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 6
    }
    
    func setBasicShadow(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 6
    }
    
    func setBasicBlueShadow(){
        //self.layer.shadowColor = UIColor.blue.cgColor
        self.layer.shadowColor = UIColor(red: 59/255, green: 84/255, blue: 213/255, alpha: 0.16).cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 6
    }
    
    func roundBorder(){
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func roundBorder(radius:CGFloat){
        self.layer.cornerRadius = radius
    }
}
