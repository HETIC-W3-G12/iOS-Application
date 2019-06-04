//
//  ProjectFinancementVC.swift
//  Euko
//
//  Created by Victor Lucas on 03/04/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class ProjectFinancementVC: UIViewController {

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
    var selected:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filltextField()
        self.view.addDismisKeyBoardOnTouch()
        self.validateButton.roundBorder()
        self.checkButton.layer.borderWidth = 2
        self.checkButton.layer.borderColor = UIColor(red: 59/255, green: 84/255, blue: 213/255, alpha: 1).cgColor
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
        if self.selected {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreationContractVC") as! CreationContractVC
            vc.isInvestor = true
            vc.projectPassed = self.project
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.showSingleAlert(title: "Important", message: "Vous devez accepter les CGU pour continuer")
        }
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkAction(_ sender: Any) {
        if (!self.selected){
            self.checkButton.setImage(UIImage(named: "checkedButton"), for: .normal)
            self.selected = true
        } else {
            self.checkButton.setImage(UIImage(), for: .normal)
            self.selected = false
        }
    }
    
    @IBAction func cguAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.urlString = " https://euko-site.000webhostapp.com/"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
