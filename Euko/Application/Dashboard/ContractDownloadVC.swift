//
//  ContractDownloadVC.swift
//  Euko
//
//  Created by Victor Lucas on 01/06/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class ContractDownloadVC: UIViewController {

    @IBOutlet weak var contractTitle: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var Afirstname: UILabel!
    @IBOutlet weak var Bfirstname: UILabel!
    @IBOutlet weak var Aapprouved: UILabel!
    @IBOutlet weak var Bapprouved: UILabel!
    @IBOutlet weak var Asignature: UIImageView!
    @IBOutlet weak var Bsignature: UIImageView!
    
    var offer:Offer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.saveButton.roundBorder()
        self.saveButton.layer.borderWidth = 2
        self.saveButton.layer.borderColor = UIColor(red: 59/255, green: 84/255, blue: 213/255, alpha: 1).cgColor
        
        self.Asignature.image  = self.offer?.ownerSignature
        self.Bsignature.image  = self.offer?.investorSignature
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        self.screenShot()
    }
    
    func screenShot() {
        self.navigationController?.navigationBar.isHidden = true
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, UIScreen.main.scale)
        self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let selectedImage = image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, nil, nil)
        
        self.showSingleAlertWithCompletion(title: "Votre contrat à bien été enregistré", message: "Vous le trouverez dans vos photos")
    }
}
