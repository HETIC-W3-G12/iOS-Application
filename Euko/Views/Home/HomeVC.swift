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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createProjectButton.layer.cornerRadius = self.createProjectButton.frame.height / 2
        
        self.shadowButton.layer.cornerRadius = self.shadowButton.frame.height / 2
        self.shadowButton.layer.shadowColor = UIColor.black.cgColor
        self.shadowButton.layer.shadowOpacity = 0.7
        self.shadowButton.layer.shadowOffset = CGSize(width: -3, height: 3)
        self.shadowButton.layer.shadowRadius = 1

    }
    
    @IBAction func createProject(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProjectVC") as! CreateProjectVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
