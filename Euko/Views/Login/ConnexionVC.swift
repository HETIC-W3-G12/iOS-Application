//
//  ConnexionVC.swift
//  Euko
//
//  Created by Victor Lucas on 07/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

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
        //TODO: Request API Here before mooving to the next view
        //TODO: Set next VC to a Root VC
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "projectNavigationController") as! UINavigationController
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = vc
    }
}

//MARK: Other functions
extension ConnexionVC {
    func setupView(){
        self.connexionButton.layer.cornerRadius = self.connexionButton.frame.height / 2
        self.connexionBackground.layer.cornerRadius = 10
        
        self.connexionBackground.dropShadow(color: UIColor.black, opacity: 0.5, offSet: .zero, radius: 10, scale: true)
    }
}
