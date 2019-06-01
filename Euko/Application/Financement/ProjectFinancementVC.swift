//
//  ProjectFinancementVC.swift
//  Euko
//
//  Created by Victor Lucas on 03/04/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class ProjectFinancementVC: UIViewController {

    // VC ou on rentre la CB ou RIB - A voir
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titlePriceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var postCodeTF: UITextField!
    @IBOutlet weak var ibanTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var birthdateTF: UITextField!
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var cguButton: UIButton!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var checkButton: UIButton!
    
    var projectId:String = ""
    var project:Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filltextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }

    func filltextField(){
        let user:User = UserDefaults.getUser()!
        
        self.nameTF.text = user.lastName
        self.firstTF.text = user.firstName
        self.postCodeTF.text = user.postCode.toString()
        self.cityTF.text = user.city
        self.addressTF.text = user.address
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: user.birthDate)
        self.birthdateTF.text = dateString
    }
    
    @IBAction func validateAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreationContractVC") as! CreationContractVC
        vc.isInvestor = true
        vc.projectPassed = self.project
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkAction(_ sender: Any) {
        
    }
    
    @IBAction func cguAction(_ sender: Any) {
        
    }
}
