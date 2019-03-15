//
//  InscriptionVC.swift
//  Euko
//
//  Created by Victor Lucas on 07/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire

class InscriptionVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var confirmationTF: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var shadowButtonView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    let dev:String = "https://euko-api-staging-pr-34.herokuapp.com"
    let prod:String = "https://euko-api-staging.herokuapp.com"
    
    var user: User = User()
    var isKeyBoardShown:Bool = false
    
    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.confirmationTF.delegate = self
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
        
        self.title = "Inscription"
        self.view.addDismisKeyBoardOnTouch()
        self.setupView()
        
        self.shadowButtonView.setSpecificShadow()
        self.shadowButtonView.roundBorder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK:- IBAction
    @IBAction func signInAction(_ sender: Any) {
        guard let mail = self.emailTF.text else {return}
        guard let password = self.passwordTF.text else {return}
        guard let confirmation = self.confirmationTF.text else {return}
        
        if (mail.count == 0 || password.count == 0 || confirmation.count == 0){
            self.showSingleAlert(title: "Erreur", message: "Veuillez indiquer tous les champs")
        } else if (password == confirmation) {
            //TODO: Checker si le mec n'a pas deja cree son compte (Appel API)
            self.user.email = mail
            self.user.password = password
            self.nextVC()
        }
        else {
            self.showSingleAlert(title: "Erreur", message: "Le mot de passe et la confirmation ne sont pas identiques")
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK:- Other functions
    func setupView() {
        self.signInButton.layer.cornerRadius = self.signInButton.frame.height / 2
        self.confirmationTF.keyboardType = .default
        self.passwordTF.keyboardType = .default
    }
    
    func nextVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InscriptionNextVC") as! InscriptionNextVC
        vc.user = self.user
        self.navigationController?.pushViewController(vc, animated: true)
    }

    //MARK:- Managing keyboard Event
    @IBAction func confirmationStartEditing(_ sender: Any) {
        self.adjustingHeight(show: true)
    }
    
    @IBAction func confirmationEndEditing(_ sender: Any) {
        self.adjustingHeight(show: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hidekeyboard()
        return true
    }
    
    func adjustingHeight(show:Bool) {
    }
    
    func hidekeyboard(){
        self.view.endEditing(true)
    }

    //MARK:- Server Bridge
    func signUp(username:String, password:String){
        let parameters:Parameters = ["email": username, "password": password]
        
        Alamofire.request(self.dev + "/users/sign_up",
                          method: .post,
                          parameters: parameters).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                print(value)
                self.showSingleAlertWithCompletion(title: "Inscription reussie", message: "Connectez-vous pour continuer", handler: { _ in 
                    self.navigationController?.popViewController(animated: true)
                })
            case .failure(let error):
                self.showSingleAlert(title: "Un probleme est survenu...", message: "Veuillez verifiez votre connexion internet")
                print(error)
            }
        }
    }
}
