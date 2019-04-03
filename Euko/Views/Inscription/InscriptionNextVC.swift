//
//  InscriptionNextVC.swift
//  Euko
//
//  Created by Victor Lucas on 12/03/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class InscriptionNextVC: UIViewController {

    @IBOutlet weak var introductionLabel: UILabel!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var birthdayDateTextField: UITextField!
    @IBOutlet weak var birthPlaceTextFied: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var postCodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var user:User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.saveButton.roundBorder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    
    func checkAllFields() -> Bool {
        self.user.lastName = self.lastNameTextField.text!
        self.user.firstName = self.firstNameTextField.text!
        self.user.setBirthDateFromString(dateString: self.birthdayDateTextField.text!)
        self.user.postCode = Int(self.postCodeTextField.text!) ?? 0
        self.user.city = self.cityTextField.text!
        self.user.address = self.addressTextField.text!
        self.user.birthPlace = self.birthPlaceTextFied.text!
        
        return true
        //TODO: Check if all textfield are okey
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if (self.checkAllFields()){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "InscriptionValidationVC") as! InscriptionValidationVC
            vc.user = self.user
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            //TODO: Ici un ou plusieurs champs sont mauvais
        }
    }
}
