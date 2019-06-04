//
//  InscriptionVC.swift
//  Euko
//
//  Created by Victor Lucas on 07/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class InscriptionVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var confirmationTF: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var shadowButtonView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    var inscription:Inscription = Inscription()
    var user:User? = nil
    var isKeyBoardShown:Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Inscription"
        confirmationTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        setupView()
    }
    
    func setupView() {
        self.view.addDismisKeyBoardOnTouch()
        shadowButtonView.setSpecificShadow()
        shadowButtonView.roundBorder()
        
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
        confirmationTF.keyboardType = .default
        passwordTF.keyboardType = .default
    }
    
    @IBAction func signInAction(_ sender: Any) {
        guard let mail = emailTF.text,
            let password = passwordTF.text,
        let confirmation = confirmationTF.text else {
            showSingleAlert(title: "Erreur sur les champs", message: "")
            return
        }
        
        if (mail.count == 0 || password.count == 0 || confirmation.count == 0){
            showSingleAlert(title: "Erreur", message: "Veuillez indiquer tous les champs")
        }
        else if (password == confirmation) {
            inscription.inscriptionEmail = mail
            inscription.inscriptionPassword = password
            nextVC()
        }
        else {
            self.showSingleAlert(title: "Erreur", message: "Le mot de passe et la confirmation ne sont pas identiques")
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }

    
    func nextVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InscriptionNextVC") as! InscriptionNextVC
        vc.inscription = inscription
        self.navigationController?.pushViewController(vc, animated: true)
    }

    //MARK:- Managing keyboard Event
    @IBAction func confirmationStartEditing(_ sender: Any) {
        adjustingHeight(show: true)
    }
    
    @IBAction func confirmationEndEditing(_ sender: Any) {
        adjustingHeight(show: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hidekeyboard()
        return true
    }
    
    func adjustingHeight(show:Bool) {
    }
    
    func hidekeyboard(){
        self.view.endEditing(true)
    }
}
