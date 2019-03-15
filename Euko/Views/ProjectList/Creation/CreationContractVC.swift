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
    @IBOutlet weak var drawSpaceView: SHFSignatureView!
    
    @IBOutlet weak var contractTitle: UILabel!
    @IBOutlet weak var approuvedContent: UILabel!
    @IBOutlet weak var contractContent: UITextView!
    @IBOutlet weak var validateButton: UIButton!
    
    var signatureImage:UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawSpaceView.delegate = self
        self.clearButton.layer.borderWidth = 2
        self.clearButton.layer.borderColor = UIColor(red: 59/255, green: 84/255, blue: 213/255, alpha: 1).cgColor
        self.clearButton.roundBorder()
        self.validateButton.roundBorder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func validateAction(_ sender: Any) {
        //TODO: Appel API pour valider le contrat
    }
    
    func drawingSignature() {
    }
    
    func image(_ signature: UIImage?) {
        self.signatureImage = signature ?? UIImage()
    }

    @IBAction func clearAction(_ sender: Any) {
        self.drawSpaceView.clear()
        self.signatureImage = UIImage()
    }
}
