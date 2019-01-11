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
        
        self.containerView.layer.cornerRadius = 8
        self.descriptionTextView.layer.cornerRadius = 3
        self.validateButton.layer.cornerRadius = self.validateButton.frame.height / 2
        
        self.shadowView.layer.cornerRadius = 8
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOpacity = 0.7
        self.shadowView.layer.shadowOffset = CGSize(width: -3, height: 3)
        self.shadowView.layer.shadowRadius = 2
        
        self.shadowButton.layer.cornerRadius = self.shadowButton.frame.height / 2
        self.shadowButton.layer.shadowColor = UIColor.black.cgColor
        self.shadowButton.layer.shadowOpacity = 0.7
        self.shadowButton.layer.shadowOffset = CGSize(width: -3, height: 3)
        self.shadowButton.layer.shadowRadius = 1
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
           // Alamofire.request("https://euko-api-staging.herokuapp.com/projects",
             //                 method: .post,
               //               parameters: parameters)
        }
        else {
            self.showBadParametersAlert()
        }
    }
}

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
