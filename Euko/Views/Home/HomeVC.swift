//
//  HomeVC.swift
//  Euko
//
//  Created by Victor Lucas on 18/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var createProjectButton: UIButton!
    @IBOutlet weak var shadowButton: UIView!
    @IBOutlet weak var moneyBackButton: UIButton!
    @IBOutlet weak var shadow2Button: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createProjectButton.layer.cornerRadius = self.createProjectButton.frame.height / 2
        
        self.moneyBackButton.layer.cornerRadius = self.moneyBackButton.frame.height / 2
        
        self.shadowButton.layer.cornerRadius = self.shadowButton.frame.height / 2
        self.shadowButton.layer.shadowColor = UIColor.black.cgColor
        self.shadowButton.layer.shadowOpacity = 0.7
        self.shadowButton.layer.shadowOffset = CGSize(width: -3, height: 3)
        self.shadowButton.layer.shadowRadius = 1

        self.shadow2Button.layer.cornerRadius = self.shadow2Button.frame.height / 2
        self.shadow2Button.layer.shadowColor = UIColor.black.cgColor
        self.shadow2Button.layer.shadowOpacity = 0.7
        self.shadow2Button.layer.shadowOffset = CGSize(width: -3, height: 3)
        self.shadow2Button.layer.shadowRadius = 1

    }
    
    @IBAction func moneyBackAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoneyBackVC") as! MoneyBackVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createProject(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProjectVC") as! CreateProjectVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
