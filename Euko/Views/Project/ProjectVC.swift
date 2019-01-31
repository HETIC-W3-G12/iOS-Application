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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var firstInformationLabel: UILabel!
    @IBOutlet weak var secondInformationLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var buttonShadowView: UIView!
    @IBOutlet weak var secondTitleLabel: UILabel!
    
    var project:Project!
    
    @IBAction func payAction(_ sender: Any) {
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK:- override
extension ProjectVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.setupField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
}

// MARK:- other functions
extension ProjectVC{
    func setupView(){
        self.buttonShadowView.setSpecificShadow()
        
        self.descriptionTextView.roundBorder(radius: 5)
        self.buttonShadowView.roundBorder()
        self.payButton.roundBorder()
    }
    
    func setupField(){
        
        
        self.titleLabel.text = String(format: "%d€ pendant %d mois", self.project.price, self.project.timeLaps)
        self.secondTitleLabel.text = self.project.title
        self.descriptionTextView.text = self.project.description
        
        let interests:Float = self.project.interests * 100
        self.firstInformationLabel.text = String(format: "%.2f%%", interests)
        
        let margin:Float = self.project.finalPrice - Float(self.project.price)
        self.secondInformationLabel.text = String(format: "%.2f€",  margin)
    }
}
