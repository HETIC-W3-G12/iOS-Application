//
//  CreationContractVC.swift
//  Euko
//
//  Created by Victor Lucas on 14/03/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class CreationContractVC: UIViewController, SHFSignatureProtocol {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var signatureImageView: UIImageView!
    @IBOutlet weak var drawSpaceView: SHFSignatureView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawSpaceView.delegate = self

    }
    
    func drawingSignature() {
        print("ok ")
    }
    
    func image(_ signature: UIImage?) {
        self.signatureImageView.image = signature
    }

    @IBAction func clearAction(_ sender: Any) {
        self.drawSpaceView.clear()
        self.signatureImageView.image = UIImage()
    }
}
