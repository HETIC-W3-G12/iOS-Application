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
    
    var inscription:Inscription? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.saveButton.roundBorder()
        self.view.addDismisKeyBoardOnTouch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    
    func validateAllFields() {
        let tmpUser = User()
        tmpUser.lastName = self.lastNameTextField.text!
        tmpUser.firstName = self.firstNameTextField.text!
        tmpUser.setBirthDateFromString(dateString: self.birthdayDateTextField.text!)
        tmpUser.postCode = Int(self.postCodeTextField.text!) ?? 0
        tmpUser.city = self.cityTextField.text!
        tmpUser.address = self.addressTextField.text!
        tmpUser.birthPlace = self.birthPlaceTextFied.text!
        self.inscription?.user = tmpUser
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.validateAllFields()
        self.signUp()
    }
    
    func signUp(){
        guard let tmpUser = self.inscription?.user else { return }
        guard let mail = self.inscription?.inscriptionEmail else { return }
        guard let password = self.inscription?.inscriptionPassword else { return }
        
        tmpUser.password = password
        tmpUser.email = mail
        
        let parameters:Parameters = ["email": tmpUser.email,
                                     "password": tmpUser.password,
                                     "firstname":tmpUser.firstName,
                                     "lastname":tmpUser.lastName,
                                     "birthdate":tmpUser.birthDate,
                                     "birthplace":tmpUser.birthPlace,
                                     "adress":tmpUser.address,
                                     "city":tmpUser.city,
                                     "postCode":tmpUser.postCode]
        
        defaultRequest(params: parameters, endpoint: endpoints.signup, method: .post) { (success, json) in
            print(json ?? "Aucun JSON disponible")
            if (success){
                let adress:String = json?["user"]["adress"].string ?? ""
                let lastname:String = json?["user"]["lastname"].string ?? ""
                let firstname:String = json?["user"]["firstname"].string ?? ""
                let birthdate:Date = json?["user"]["birthdate"].string?.toDate() ?? "".toDate()
                let email:String = json?["user"]["email"].string ?? ""
                let id:String = json?["user"]["id"].string ?? ""
                let birthplace:String = json?["user"]["birthplace"].string ?? ""
                let city:String = json?["user"]["city"].string ?? ""
                let postCode:Int = json?["user"]["postCode"].int ?? 0
                let token:String = json?["token"].string ?? ""
                
                self.inscription?.user = User(id: id, token: token, email: email, password: tmpUser.password,
                                              firstName: firstname, lastName: lastname, address: adress,
                                              postCode: postCode, city: city, birthPlace: birthplace, birthDate: birthdate)
                
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "InscriptionValidationVC") as! InscriptionValidationVC
                vc.inscription = self.inscription
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                self.showSingleAlert(title: "Erreur lors de la reception des données", message: "Veuillez contacter le support : support@euko.com")
                print("No success...")
            }
        }
    }
}
