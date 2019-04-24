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
        self.uploadFace()
    }
    
    func uploadFace(){
        let user:User = UserDefaults.getUser()!
        let bearer:String = "Bearer \(user.token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        
        let data = self.resizeImage(image: self.selfieImageView.image!)
        let base64EncodedString = data.base64EncodedString()
        let parameters:Parameters = ["file": base64EncodedString]
        headersRequest(params: parameters, endpoint: .uploadFace, method: .post, header: headers, handler: { (success, json) in
            if (success){
                self.uploadIdentity()
            }
        })
    }

    func uploadIdentity(){
        let user:User = UserDefaults.getUser()!
        let bearer:String = "Bearer \(user.token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        
        let data = self.resizeImage(image: self.identityImageView.image!)
        let base64EncodedString = data.base64EncodedString()
        let parameters:Parameters = ["file": base64EncodedString]
        headersRequest(params: parameters, endpoint: .uploadIdentity, method: .post, header: headers, handler: { (success, json) in
            if (success){
                self.showSingleAlertWithCompletion(title: "Inscription terminée",
                                                   message: "",
                                                   handler: { _ in
                                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectListVC") as! ProjectListVC
                                                    let navigationController = UINavigationController(rootViewController: vc)
                                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                                    appDelegate.window?.rootViewController = navigationController })
            }
        })
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
    
    func resizeImage(image: UIImage) -> Data {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 100.0
        let maxWidth: Float = 100.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.1
        //50 percent compression
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        let rect = CGRect(x: 0, y: 0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img?.jpegData(compressionQuality:CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return imageData!
    }
}
