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

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var connexionButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var connexionBackground: UIView!
    
}

//MARK: override
extension ConnexionVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.view.addDismisKeyBoardOnTouch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
}

//MARK: IBAction
extension ConnexionVC {
    @IBAction func connectAction(_ sender: Any) {
        
        let username = self.emailTF.text ?? ""
        let password = self.passwordTF.text ?? ""
        
        if (username == "" || password == ""){
            // TODO: Error on textfields
        } else {
            self.connect(username: username, password: password)
        }
    }
}

//MARK: Other functions
extension ConnexionVC {
    func setupView(){
        self.connexionButton.layer.cornerRadius = self.connexionButton.frame.height / 2
        self.connexionBackground.layer.cornerRadius = 10
        
        self.connexionBackground.dropShadow(color: UIColor.black, opacity: 0.5, offSet: .zero, radius: 10, scale: true)
    }
    
    func nextVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "projectNavigationController") as! UINavigationController
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = vc
    }
}

//MARK: Server Bridge
extension ConnexionVC {
    func connect(username:String, password:String){
        
        let parameters:Parameters = ["email": username,
                                     "password": password]
        
        Alamofire.request("https://euko-api-staging.herokuapp.com/users/sign_in",
                          method: .post,
                          parameters:parameters).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json["user"]["email"])
                print(json["user"]["id"])
                print(json["user"]["password"])
                print(json["token"])
                self.nextVC()
            case .failure(let error):
                print(error)
            }
        }
    }
}
