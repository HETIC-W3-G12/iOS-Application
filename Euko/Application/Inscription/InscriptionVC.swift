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
    
    var user: User = User()
    var isKeyBoardShown:Bool = false
    
    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Inscription"
        self.confirmationTF.delegate = self
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
        self.setupView()
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
            self.user.email = mail
            self.user.password = password
            self.nextVC()
        }
        else {
            self.showSingleAlert(title: "Erreur", message: "Le mot de passe et la confirmation ne sont pas identiques")
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }

    //MARK:- Other functions
    func setupView() {
        self.view.addDismisKeyBoardOnTouch()
        self.shadowButtonView.setSpecificShadow()
        self.shadowButtonView.roundBorder()

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
}