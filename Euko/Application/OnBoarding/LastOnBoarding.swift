//
//  LastOnBoarding.swift
//  Euko
//
//  Created by Victor Lucas on 24/04/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class LastOnBoarding: UIViewController {

    @IBOutlet weak var connectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.connectionButton.roundBorder()
    }
    
    
    @IBAction func connectAction(_ sender: Any) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "connexionNavigationController") as! UINavigationController
        
        appdelegate.window!.rootViewController = vc
    }
}
