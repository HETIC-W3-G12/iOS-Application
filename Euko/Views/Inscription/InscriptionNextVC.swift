//
//  InscriptionNextVC.swift
//  Euko
//
//  Created by Victor Lucas on 12/03/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
           self.signUp()
        } else {
            //TODO: Ici un ou plusieurs champs sont mauvais
        }
    }
    
    func signUp(){
        let parameters:Parameters = ["email": self.user.email,
                                     "password": self.user.password,
                                     "firstname":self.user.firstName,
                                     "lastname":self.user.lastName,
                                     "birthdate":self.user.birthDate,
                                     "birthplace":self.user.birthPlace,
                                     "adress":self.user.address,
                                     "city":self.user.city,
                                     "postCode":self.user.postCode]
        defaultRequest(params: parameters, endpoint: endpoints.signup, method: .post) { (success, json) in
            print(json ?? "Aucun JSON disponible")
            if (success){
                let email:String = json?["user"]["email"].string ?? ""
                let id:String = json?["user"]["id"].string ?? ""
                let token:String = json?["token"].string ?? ""
                
                let user = User(id: id, token: token, email: email)
                UserDefaults.setUser(user: user)
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "InscriptionValidationVC") as! InscriptionValidationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                print("json")
            }
        }
    }
}
