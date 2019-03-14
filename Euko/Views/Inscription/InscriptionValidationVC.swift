//
//  InscriptionValidationVC.swift
//  Euko
//
//  Created by Victor Lucas on 13/03/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

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

    var user:User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.takeSelfieButton.roundBorder()
        self.addIdentityCardButton.roundBorder()
        self.validateButton.roundBorder()
        
        self.imagePicker.delegate = self
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func takeSelfie(_ sender: Any) {
    }
    
    @IBAction func addIdentitycard(_ sender: Any) {
    }
    
    @IBAction func validateInscription(_ sender: Any) {
    }
    
    func presentImagePickerFromCamera(source:UIImagePickerController.SourceType = .savedPhotosAlbum){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = source
        
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.selfieImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
