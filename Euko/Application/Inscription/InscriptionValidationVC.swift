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
    var inscription:Inscription? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inscription?.delegate = self
        self.imagePicker.delegate = self
        self.setupView()
    }
    
    func setupView(){
        self.takeSelfieButton.roundBorder()
        self.addIdentityCardButton.roundBorder()
        self.validateButton.roundBorder()
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
        self.inscription?.uploadImages()
    }
    
    func presentImagePickerFromCamera(source:UIImagePickerController.SourceType = .savedPhotosAlbum){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = source
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            if (self.isTakingSelfie){
                self.inscription?.selfieImage = pickedImage
                self.selfieImageView.image = pickedImage
            } else {
                self.inscription?.identityImage = pickedImage
                self.identityImageView.image = pickedImage
            }
            dismiss(animated: true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension InscriptionValidationVC: InscriptionDelegate {
    func uploadsFinished() {
        self.showSingleAlertWithCompletion(title: "Inscription terminée",
                                           message: "",
                                           handler: { _ in
                                            self.connect()
        })
    }
    
    func errorOnUpload() {
        self.showSingleAlertWithCompletion(title: "Erreur pendant l'envoie des photos",
                                           message: "Veulliez vérifier votre connexion internet",
                                           handler: { _ in
        })
    }
    
    func errorOnImages(){
        self.showSingleAlertWithCompletion(title: "Erreur sur les photos",
                                           message: "Veulliez es vérifier avant de recommencer",
                                           handler: { _ in
        })
    }
    
    func connect(){
        let parameters:Parameters = ["email":self.inscription?.user?.email ?? "", "password":self.inscription?.user?.password ?? ""]
        
        defaultRequest(params: parameters, endpoint: endpoints.connexion, method: .post, handler: { (success, json) in
            print(json ?? "Aucun JSON disponible")
            if (success){
                //TODO: parse json
                let adress:String = json?["user"]["adress"].string ?? ""
                let lastname:String = json?["user"]["lastname"].string ?? ""
                let firstname:String = json?["user"]["firstname"].string ?? ""
                let birthdate:Date = json?["user"]["birthdate"].string?.toDate() ?? "".toDate()
                let email:String = json?["user"]["email"].string ?? ""
                let id:String = json?["user"]["id"].string ?? ""
                let birthplace:String = json?["user"]["birthplace"].string ?? ""
                let city:String = json?["user"]["city"].string ?? ""
                let postCode:Int = json?["user"]["postCode"].int ?? 0
                let token:String = json?["token"].string ?? ""
                
                let user = User(id: id, token: token, email: email, password: "",
                                firstName: firstname, lastName: lastname, address: adress,
                                postCode: postCode, city: city, birthPlace: birthplace, birthDate: birthdate)
                UserDefaults.setUser(user: user)
                self.nextVC()
            }
            else {
                self.showSingleAlert(title: "Identifiants inccorects", message: "L'email ou le mot de passe sont incorrects")
            }
        })
    }
    
    func nextVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = vc
    }
}
