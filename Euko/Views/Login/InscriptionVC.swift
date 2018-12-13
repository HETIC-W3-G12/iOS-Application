//
//  InscriptionVC.swift
//  Euko
//
//  Created by Victor Lucas on 07/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class InscriptionVC: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var confirmationTF: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var user: User = User(email: nil)
    var isKeyBoardShown:Bool = false
}

//MARK: Override
extension InscriptionVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confirmationTF.delegate = self
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
        
        self.title = "Inscription"
        self.setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            //TODO: REQUETE API INSCRIPTION
        }
        else {
            self.showSingleAlert(title: "Erreur", message: "Le mot de passe et la confirmation ne sont pas identiques")
        }
    }
}

//MARK: Other functions
extension InscriptionVC {
    func setupView() {
        self.backgroundView.layer.cornerRadius = 10
        self.signInButton.layer.cornerRadius = self.signInButton.frame.height / 2
        self.confirmationTF.keyboardType = .default
        self.passwordTF.keyboardType = .default
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
        let changeInHeight:CGFloat = (40.0) * (show ? 1 : -1)
        self.bottomConstraint.constant += changeInHeight
    }
    
    func hidekeyboard(){
        self.view.endEditing(true)
    }
}
