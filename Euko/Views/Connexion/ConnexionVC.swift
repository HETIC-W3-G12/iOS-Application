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
        
    var delegate:ServerBridgeDelegate?

    //MARK:- override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
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
            //self.connect(username: username, password: password)
            self.nextVC()
        }
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
extension ConnexionVC: ServerBridgeDelegate {
    func connect(username:String, password:String){
        self.startActivity()
        let parameters:Parameters = ["email":username, "password":password]
        
        ServerBridge().connectUser(params:parameters, method:HTTPMethod.post)
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
