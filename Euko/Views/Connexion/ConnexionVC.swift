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
    
    
    static let dev:String = "https://euko-api-staging-pr-34.herokuapp.com"
    static let prod:String = "https://euko-api-staging.herokuapp.com"

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
            //TODO: Handle connection
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
    
    func nextVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBar") as! UITabBarController
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = vc
    }
    
    //MARK:- Server Bridge
    func connect(username:String, password:String){
        
        self.activityView.isHidden = false
        self.activityIndicator.startAnimating()

        let parameters:Parameters = ["email": username,
                                     "password": password]
        
        Alamofire.request(self.dev + "/users/sign_in",
                          method: .post,
                          parameters:parameters).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                self.activityView.isHidden = true
                self.activityIndicator.stopAnimating()
                
                print(value)
                let json = JSON(value)
                
                UserDefaults.setToken(token: json["token"].string!)
                // TODO: Check if a user has a loan already...
                UserDefaults.setLoan(loan: true)
                self.nextVC()
            case .failure(let error):
                self.activityView.isHidden = true
                self.activityIndicator.stopAnimating()
                print(error)
            }
        }
    }
}
