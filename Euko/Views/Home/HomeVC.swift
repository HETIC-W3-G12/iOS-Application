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
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var shadowProfil: UIView!
    @IBOutlet weak var profilButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension HomeVC {
    @IBAction func moneyBackAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoneyBackVC") as! MoneyBackVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createProject(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProjectVC") as! CreateProjectVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension HomeVC {
    func setupViews(){
        self.profilButton.roundBorder()
        self.createProjectButton.roundBorder()
        self.moneyBackButton.roundBorder()
        
        self.shadowProfil.setSpecificShadow()
        self.shadowButton.setSpecificShadow()
        self.shadow2Button.setSpecificShadow()
        
        self.shadowProfil.roundBorder()
        self.shadowButton.roundBorder()
        self.shadow2Button.roundBorder()
    }
}
