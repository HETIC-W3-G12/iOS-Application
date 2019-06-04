//
//  WebViewController.swift
//  Euko
//
//  Created by Victor Lucas on 03/06/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var web: UIWebView!
    
    var urlString:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: urlString) else {
            self.showSingleAlertWithCompletion(title: "Erreur lors du chargement des CGU...", message: "", handler: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            return
        }
        let request = URLRequest(url: url)
        self.web.loadRequest(request)
    }
}
