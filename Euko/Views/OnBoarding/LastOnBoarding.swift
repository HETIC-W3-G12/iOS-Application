//
//  LastOnBoarding.swift
//  Euko
//
//  Created by Victor Lucas on 24/04/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class LastOnBoarding: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func nextAction(_ sender: Any) {
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "connexionNavigationController") as! UINavigationController
        //self.navigationController?.pushViewController(vc, animated: true)
        
        self.navigationController?.popViewController(animated: true)
    }
}
