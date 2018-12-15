//
//  ProjectVC.swift
//  Euko
//
//  Created by Victor Lucas on 15/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class ProjectVC: UIViewController {

    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowButton: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var firstInformationLabel: UILabel!
    @IBOutlet weak var secondInformationLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    
    
    var project:Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.payButton.layer.cornerRadius = self.payButton.frame.height / 2
        self.shadowButton.layer.cornerRadius = self.shadowButton.frame.height / 2
        self.shadowButton.layer.shadowColor = UIColor.black.cgColor
        self.shadowButton.layer.shadowOpacity = 0.7
        self.shadowButton.layer.shadowOffset = CGSize(width: -3, height: 3)
        self.shadowButton.layer.shadowRadius = 1
        
        self.descriptionTextView.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.titleLabel.text = self.project.title
        self.descriptionTextView.text = self.project.description
        
        let price:Int = self.project.price
        let timeLaps:Int = self.project.timeLaps
        self.firstInformationLabel.text = "\(price)€ sur \(timeLaps) mois"
        
        let interests:Float = self.project.interests * 100
        let margin:Float = self.project.finalPrice - Float(self.project.price)
        self.secondInformationLabel.text = String(format: "%.2f%% intérêts | %.2f€ de bénéfices", interests,  margin)
        
        if (self.descriptionTextView.contentSize.height > 250) {
            self.textViewHeightConstraint.constant = 250
            self.descriptionTextView.isScrollEnabled = true
        } else {
            self.textViewHeightConstraint.constant = self.descriptionTextView.contentSize.height + 26
            self.descriptionTextView.isScrollEnabled = false
        }
    }
    
    @IBAction func payAction(_ sender: Any) {
        
    }
}
