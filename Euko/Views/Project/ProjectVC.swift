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
    
    @IBAction func payAction(_ sender: Any) {
        
    }
}

// MARK: override
extension ProjectVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setupField()
    }
}

// MARK: other functions
extension ProjectVC{
    func setupView(){
        self.descriptionTextView.roundBorder(radius: 5)
        self.shadowButton.roundBorder()
        self.payButton.roundBorder()
        
        self.shadowButton.setSpecificShadow()
    }
    
    func setupField(){
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
}
