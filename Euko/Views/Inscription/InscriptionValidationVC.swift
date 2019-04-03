//
//  InscriptionValidationVC.swift
//  Euko
//
//  Created by Victor Lucas on 13/03/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InscriptionValidationVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nonPublicationLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var takeSelfieButton: UIButton!
    @IBOutlet weak var addIdentityCardButton: UIButton!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var identityImageView: UIImageView!
    @IBOutlet weak var selfieImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var isTakingSelfie:Bool = false

    var user:User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.takeSelfieButton.roundBorder()
        self.addIdentityCardButton.roundBorder()
        self.validateButton.roundBorder()
        self.imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func takeSelfie(_ sender: Any) {
        self.isTakingSelfie = true
        self.presentImagePickerFromCamera(source: .savedPhotosAlbum)
    }
    
    @IBAction func addIdentitycard(_ sender: Any) {
        self.isTakingSelfie = false
        self.presentImagePickerFromCamera(source: .savedPhotosAlbum)
    }

    @IBAction func validateInscription(_ sender: Any) {
        let parameters:Parameters = ["email": self.user.email,
                                     "password": self.user.password,
                                     "firstname":self.user.firstName,
                                     "lastname":self.user.lastName,
                                     "birthdate":self.user.birthDate,
                                     "birthplace":self.user.birthPlace,
                                     "adress":self.user.address,
                                     "city":self.user.city,
                                     "postCode":self.user.postCode]
        defaultRequest(params: parameters, endpoint: endpoints.signup, method: .post) { (success, json) in
            print(json ?? "Aucun JSON disponible")
            self.showSingleAlertWithCompletion(title: "Inscription terminée",
                                               message: "Vous pouvez-maintenant vous connecter",
                                               handler: { _ in
              self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }

    
    func presentImagePickerFromCamera(source:UIImagePickerController.SourceType = .savedPhotosAlbum){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = source
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if (self.isTakingSelfie){
                self.selfieImageView.image = pickedImage
            } else {
                self.identityImageView.image = pickedImage
            }
            dismiss(animated: true, completion: nil)
        }
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK:- Server Bridge
extension InscriptionValidationVC {
    func defaultResponse(succed: Bool, json: JSON?) {
        if (succed){
            self.showSingleAlertWithCompletion(title: "Inscription validée",
                                               message: "Vous pouvez maintenant vous connecter",
                                               handler: { _ in
                                                self.navigationController?.popToRootViewController(animated: true)})
            
            } else {
            self.showSingleAlert(title: "Un probleme est survenu...",
                                 message: "Veuillez verifiez votre connexion internet")
        }
    }
}
