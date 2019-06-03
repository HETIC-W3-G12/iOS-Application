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
        
        //self.web.loadRequest(URLRequest(url: URL(string: self.urlString)!))
    }
    
}
