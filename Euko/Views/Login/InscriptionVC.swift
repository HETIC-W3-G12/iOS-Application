//
//  InscriptionVC.swift
//  Euko
//
//  Created by Victor Lucas on 07/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire

class InscriptionVC: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var confirmationTF: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var shadowButtonView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityView: UIView!
    
    let dev:String = "https://euko-api-staging-pr-34.herokuapp.com"
    let prod:String = "https://euko-api-staging.herokuapp.com"
    
    var user: User = User(email: nil)
    var isKeyBoardShown:Bool = false
}

//MARK: Override
extension InscriptionVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stopActivity()
        
        self.confirmationTF.delegate = self
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
        
        self.title = "Inscription"
        self.setupView()
        self.view.addDismisKeyBoardOnTouch()
        
        
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
}

//MARK: IBAction
extension InscriptionVC {
    @IBAction func signInAction(_ sender: Any) {
        guard let mail = self.emailTF.text else {return}
        guard let password = self.passwordTF.text else {return}
        guard let confirmation = self.confirmationTF.text else {return}
        
        if (mail.count == 0 || password.count == 0 || confirmation.count == 0){
            self.showSingleAlert(title: "Erreur", message: "Veuillez indiquer tous les champs")
        } else if (password == confirmation) {
            self.signUp(username: mail, password: password)
        }
        else {
            self.showSingleAlert(title: "Erreur", message: "Le mot de passe et la confirmation ne sont pas identiques")
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: Other functions
extension InscriptionVC {
    func setupView() {
        self.signInButton.layer.cornerRadius = self.signInButton.frame.height / 2
        self.confirmationTF.keyboardType = .default
        self.passwordTF.keyboardType = .default
        
        self.activityView.layer.cornerRadius = 5
    }
    
    func startAcitiviy(){
        self.activityIndicator.startAnimating()
        self.activityView.isHidden = false
    }
    
    func stopActivity(){
        self.activityView.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}

//MARK: Managing keyboard Event
extension InscriptionVC: UITextFieldDelegate {
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
}

//MARK: Server Bridge
extension InscriptionVC {
    func signUp(username:String, password:String){
        
        self.startAcitiviy()

        let parameters:Parameters = ["email": username,
                                     "password": password]
        
        Alamofire.request(self.dev + "/users/sign_up",
                          method: .post,
                          parameters: parameters).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                self.stopActivity()
                print(value)
                self.showSingleAlertWithCompletion(title: "Inscription reussie", message: "Connectez-vous pour continuer", handler: { _ in 
                    self.navigationController?.popViewController(animated: true)
                })
            case .failure(let error):
                self.stopActivity()
                self.showSingleAlert(title: "Un probleme est survenu...", message: "Veuillez verifiez votre connexion internet")
                print(error)
            }
        }
    }
}
