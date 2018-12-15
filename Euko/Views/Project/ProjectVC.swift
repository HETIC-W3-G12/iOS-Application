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
    
    
    var project:Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.payButton.layer.cornerRadius = self.payButton.frame.height / 2
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
        self.secondInformationLabel.text = "\(interests)% intérêts | \(margin)€ de bénéfices"
    }
    
    @IBAction func payAction(_ sender: Any) {
        
    }
}
