//
//  ExtViewController.swift
//  Euko
//
//  Created by Victor Lucas on 11/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

extension UIViewController {
    func showSingleAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func showSingleAlertWithCompletion(title:String, message:String, handler: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        
        self.present(alert, animated: true)
    }
}
