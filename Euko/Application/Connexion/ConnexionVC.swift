//
//  ConnexionVC.swift
//  Euko
//
//  Created by Victor Lucas on 07/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ConnexionVC: UIViewController {

    @IBOutlet weak var connexionShadow: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var connexionButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.view.addDismisKeyBoardOnTouch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    //MARK:- IBAction
    @IBAction func connectAction(_ sender: Any) {
        
        let username = self.emailTF.text ?? ""
        let password = self.passwordTF.text ?? ""

        if (username == "" || password == ""){
            //TODO: Error on textfields
        } else {
            self.connect(username: username, password: password)
        }
    }
    
    @IBAction func noAccountAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InscriptionVC") as! InscriptionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    //MARK:- Other functions
    func setupView(){
        self.connexionButton.roundBorder()
        self.connexionShadow.setSpecificShadow()
        self.connexionShadow.roundBorder()
        self.activityView.layer.cornerRadius = 5
        self.activityView.isHidden = true
    }
    
    func startActivity(){
        self.activityView.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func stopActivity(){
        self.activityView.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    func nextVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = vc
    }
}

//MARK:- Server Bridge
extension ConnexionVC {
    func connect(username:String, password:String){
        self.startActivity()
        let parameters:Parameters = ["email":username, "password":password]
        
        defaultRequest(params: parameters, endpoint: endpoints.connexion, method: .post, handler: { (success, json) in
            print(json ?? "Aucun JSON disponible")
            self.stopActivity()
            if (success){
                //TODO: parse json
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
                
                let user = User(id: id, token: token, email: email, password: "",
                                firstName: firstname, lastName: lastname, address: adress,
                                postCode: postCode, city: city, birthPlace: birthplace)
                UserDefaults.setUser(user: user)
                self.nextVC()
            }
            else {
                self.showSingleAlert(title: "Identifiants inccorects", message: "L'email ou le mot de passe sont incorrects")
            }
        })
    }
    
    func defaultResponse(succed:Bool, json:JSON?){
        self.stopActivity()
        if (succed){
            UserDefaults.setToken(token: json?["token"].string ?? "")
            UserDefaults.setLoan(loan: true)
            self.nextVC()
        }
    }
}
