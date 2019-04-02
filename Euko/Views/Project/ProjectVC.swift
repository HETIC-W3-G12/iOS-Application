//
//  ProjectVC.swift
//  Euko
//
//  Created by Victor Lucas on 15/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class ProjectVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var firstInformationLabel: UILabel!
    @IBOutlet weak var secondInformationLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var buttonShadowView: UIView!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var changingLabel: UILabel!
    
    var project:Project!
    var isLoan:Bool! = false
    
    @IBAction func payAction(_ sender: Any) {
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK:- override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true

        self.setupField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK:- other functions
    func setupView(){
        self.buttonShadowView.setSpecificShadow()
        self.descriptionTextView.roundBorder(radius: 5)
        self.buttonShadowView.roundBorder()
        self.payButton.roundBorder()
    }
    
    func setupField(){
        self.secondTitleLabel.text = self.project.title
        self.descriptionTextView.text = self.project.description
        self.titleLabel.text = String(format: "%d€ pendant %d mois", self.project.price, self.project.timeLaps)
        
        let interests:Float = self.project.interests * 100
        self.firstInformationLabel.text = String(format: "%.2f%%", interests)

        if (self.isLoan){
            self.payButton.isHidden = true
            let totalAmount = self.project.finalPrice!
            self.secondInformationLabel.text = String(format: "%.2f€",  totalAmount)
            self.changingLabel.text = "à rembourser"
        } else {
            self.payButton.isHidden = false
            let margin:Float = self.project.finalPrice - Float(self.project.price)
            self.secondInformationLabel.text = String(format: "%.2f€",  margin)
            self.changingLabel.text = "de bénéfices"
        }
    }
}
