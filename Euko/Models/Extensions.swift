//
//  Extensions.swift
//  Euko
//
//  Created by Victor Lucas on 07/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

extension UIViewController {
    func showSingleAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}

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
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: -4, height: 4)
        self.layer.shadowRadius = 2
    }
    
    func roundBorder(){
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func roundBorder(radius:CGFloat){
        self.layer.cornerRadius = radius
    }
}

extension String
{
    //right is the first encountered string after left
    func between(_ left: String, _ right: String) -> String? {
        guard
            let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards)
            , leftRange.upperBound <= rightRange.lowerBound
            else { return nil }
        
        let sub = self[leftRange.upperBound...]
        let closestToLeftRange = sub.range(of: right)!
        return String(sub[..<closestToLeftRange.lowerBound])
    }
    
    var length: Int {
        get {
            return self.count
        }
    }
    
    func substring(to : Int) -> String {
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[...toIndex])
    }
    
    func substring(from : Int) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }
    
    func substring(_ r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        let indexRange = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return String(self[indexRange])
    }
    
    func character(_ at: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: at)]
    }
    
    func lastIndexOfCharacter(_ c: Character) -> Int? {
        return range(of: String(c), options: .backwards)?.lowerBound.encodedOffset
    }
}

extension UserDefaults {
    static let TOKEN_FLAG = "tokenFlag"
    static let LOAN_FLAG = "loanFlag"
    
    static func setToken(token:String){
        UserDefaults.standard.set(token, forKey:TOKEN_FLAG)
    }
    
    static func getToken() -> String? {
        return UserDefaults.standard.value(forKey: TOKEN_FLAG) as? String
    }
    
    static func setLoan(loan:Bool){
        UserDefaults.standard.set(loan, forKey:LOAN_FLAG)
    }
    
    static func getLoan() -> Bool! {
        return UserDefaults.standard.value(forKey: LOAN_FLAG) as! Bool
    }
    
}
