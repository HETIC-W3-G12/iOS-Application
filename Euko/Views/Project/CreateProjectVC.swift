//
//  CreateProjectVC.swift
//  Euko
//
//  Created by Victor Lucas on 18/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire

class CreateProjectVC: UIViewController {

    
    @IBOutlet weak var titletextField: UITextField!
    @IBOutlet weak var priceTexfield: UITextField!
    @IBOutlet weak var timeLapsTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var shadowButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addDismisKeyBoardOnTouch()
        
        self.descriptionTextView.delegate = self

        self.shadowView.setSpecificShadow()
        self.shadowButton.setSpecificShadow()

        self.containerView.roundBorder(radius: 8)
        self.descriptionTextView.roundBorder(radius: 3)
        self.shadowButton.roundBorder()
        self.validateButton.roundBorder()
    }
        
    @IBAction func validateAction(_ sender: Any) {
        
        let title = self.titletextField.text ?? ""
        let desc = self.descriptionTextView.text ?? ""
        let price = Int(self.priceTexfield.text!) ?? 0
        let time = Int(self.timeLapsTextField.text!) ?? 0
        
        let state = "valid"
        let interests = 0.1
        
        var somethingIsWrong = false
        
        let parameters: Parameters = ["title": title,
                                      "description": desc,
                                      "price": price,
                                      "interests": interests,
                                      "state": state,
                                      "timeLaps": time]
        
        
        if (title == ""){
            UIView.animate(withDuration: 0.5, animations: {
                self.titletextField.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
            })
            somethingIsWrong = true
        }
        if (desc == ""){
            UIView.animate(withDuration: 0.5, animations: {
                self.descriptionTextView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
            })
            somethingIsWrong = true
        }
        if (price < 100 || price > 760){
            UIView.animate(withDuration: 0.5, animations: {
                self.priceTexfield.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
            })
            somethingIsWrong = true
        }
        if (time < 1 || time > 12) {
            UIView.animate(withDuration: 0.5, animations: {
                self.timeLapsTextField.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
            })
            somethingIsWrong = true
        }
        
        if (!somethingIsWrong) {
            self.createProjectWithParameters(parameters: parameters)
        }
        else {
            self.showBadParametersAlert()
        }
    }
}

// MARK: Error Handling
extension CreateProjectVC: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView){
        self.descriptionTextView.backgroundColor = UIColor.white
    }
    
    @IBAction func startEditPrice(_ sender: Any) {
        self.priceTexfield.backgroundColor = UIColor.white
    }
    
    @IBAction func startEditTime(_ sender: Any) {
        self.timeLapsTextField.backgroundColor = UIColor.white
    }
    
    @IBAction func startEditTitle(_ sender: Any) {
        self.titletextField.backgroundColor = UIColor.white
    }
        
    func showBadParametersAlert(){
        self.showSingleAlert(title: "Certains champs sont incorrects",
                             message: "Le prix doit être compris entre 100 et 760€.\n\nLa durée de l'emprunt entre 1 et 12 mois.")
    }
}

// MARK: Server Bridge
extension CreateProjectVC {
    func createProjectWithParameters(parameters: Parameters){
        
        let token:String = UserDefaults.getToken() ?? ""
        
        if (token != ""){
            let bearer:String = "Bearer \(token)"
            
            let headers: HTTPHeaders = [
                "Authorization": bearer,
                "Accept": "application/json"]
            
            Alamofire.request("https://euko-api-staging.herokuapp.com/projects", method: .post, parameters: parameters, headers:headers).validate().responseJSON{ response in
                switch response.result {
                case .success(let value):
                    print(value)
                    self.navigationController?.popToRootViewController(animated: true)
                    
                case.failure(let error):
                    print(error)
                    self.showSingleAlert(title: "Une erreure s'est produite", message: "Veuillez vérifier votre connexion internet.")
                }
            }
        } else {
            // No Token ID... User should reconnect ? Should never appear
        }
        
    }
}
