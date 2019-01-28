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

        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkHasLoan()
        self.setupButtons()
    }
    
    func setupButtons(){
            self.moneyBackButton.isHidden = !UserDefaults.getLoan()
            self.shadow2Button.isHidden = !UserDefaults.getLoan()
            
            self.createProjectButton.isHidden = UserDefaults.getLoan()
            self.shadowButton.isHidden = UserDefaults.getLoan()
    }
    
    func setupViews(){
        self.createProjectButton.roundBorder()
        self.moneyBackButton.roundBorder()
        
        self.shadowButton.setSpecificShadow()
        self.shadow2Button.setSpecificShadow()
        
        self.shadowButton.roundBorder()
        self.shadow2Button.roundBorder()
    }
    
    @IBAction func moneyBackAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoneyBackVC") as! MoneyBackVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createProject(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProjectVC") as! CreateProjectVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkHasLoan(){
        UserDefaults.getLoan() ? UserDefaults.setLoan(loan: false) : UserDefaults.setLoan(loan: true)
    }
    
}
