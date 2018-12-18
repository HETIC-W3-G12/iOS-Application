//
//  CreateProjectVC.swift
//  Euko
//
//  Created by Victor Lucas on 18/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class CreateProjectVC: UIViewController {

    
    @IBOutlet weak var titletextField: UITextField!
    @IBOutlet weak var priceTexfield: UITextField!
    @IBOutlet weak var timeLapsTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var shadowButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addDismisKeyBoardOnTouch()
        
        self.containerView.layer.cornerRadius = 8
        self.descriptionTextView.layer.cornerRadius = 3
        self.validateButton.layer.cornerRadius = self.validateButton.frame.height / 2
        
        self.shadowView.layer.cornerRadius = 8
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOpacity = 0.7
        self.shadowView.layer.shadowOffset = CGSize(width: -3, height: 3)
        self.shadowView.layer.shadowRadius = 2
        
        self.shadowButton.layer.cornerRadius = self.shadowButton.frame.height / 2
        self.shadowButton.layer.shadowColor = UIColor.black.cgColor
        self.shadowButton.layer.shadowOpacity = 0.7
        self.shadowButton.layer.shadowOffset = CGSize(width: -3, height: 3)
        self.shadowButton.layer.shadowRadius = 1
    }
    
    @IBAction func validateAction(_ sender: Any) {
    }
}
