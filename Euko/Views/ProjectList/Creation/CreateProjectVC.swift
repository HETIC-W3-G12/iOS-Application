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

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var titletextField: UITextField!
    @IBOutlet weak var interestsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var timeLapsLabel: UILabel!
    @IBOutlet weak var timeLapsSlider: UISlider!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var shadowButton: UIView!
    
    @IBOutlet weak var keyboardConstraint: NSLayoutConstraint!
    
    static let dev:String = "https://euko-api-staging-pr-34.herokuapp.com"
    static let prod:String = "https://euko-api-staging.herokuapp.com"
    
    var keyboardHeight:CGFloat = 200
    var keyboardAnimation:Float = 0

    //MARK:- overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addDismisKeyBoardOnTouch()
        
        self.descriptionTextView.delegate = self
        self.shadowButton.setSpecificShadow()
        self.descriptionTextView.roundBorder(radius: 3)
        self.shadowButton.roundBorder()
        self.validateButton.roundBorder()
        self.setInterests()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyboardHeight = keyboardSize.height
            print(keyboardHeight)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    // MARK:- Actions
    @IBAction func priceChanged(_ sender: Any) {
        self.priceLabel.text = String(format: "%.f euros", ceil(self.priceSlider.value) * 10)
        self.setInterests()
    }
    
    @IBAction func timeLapsChanged(_ sender: Any) {
        self.timeLapsLabel.text = String(format: "%.f mois", self.timeLapsSlider.value)
        self.setInterests()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func validateAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreationContractVC") as! CreationContractVC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        //TODO: Activate API Call
/*
        let title = self.titletextField.text ?? ""
        let desc = self.descriptionTextView.text ?? ""
        let price = Int(ceil(self.priceSlider.value) * 10)
        let time = Int(self.timeLapsSlider.value)
        let state = 1 //Enum in backend : 1 = valid
        let interests = 0.1
        
        if (self.areTextFieldsCorrects(title: title, description: desc)) {
            let parameters: Parameters = ["title": title,
                                          "description": desc,
                                          "price": price,
                                          "interests": interests,
                                          "state": state,
                                          "timeLaps": time]
            
            self.createProjectWithParameters(parameters: parameters)
        }
        else {
            self.showBadParametersAlert()
        }
 */
    }

    @IBAction func startEditTitle(_ sender: Any) {
        self.titletextField.backgroundColor = UIColor.white
    }
    
    // MARK:- Functions
    func showBadParametersAlert(){
        self.showSingleAlert(title: "Certains champs sont incorrects",
                             message: "Le prix doit être compris entre 100 et 760€.\n\nLa durée de l'emprunt entre 1 et 12 mois.")
    }
    
    func setInterests(){
        self.interestsLabel.text = String(format: "%.f€",
                                          ((ceil(self.priceSlider.value) * 10) * 0.1 / 12) * self.timeLapsSlider.value)
    }
    
    func areTextFieldsCorrects(title:String, description:String) -> Bool {
        if (title == ""){
            UIView.animate(withDuration: 0.5, animations: {
                self.titletextField.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
            })
            return false
        }
        if (description == ""){
            UIView.animate(withDuration: 0.5, animations: {
                self.descriptionTextView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
            })
            return false
        }
        return true
    }

}

// MARK:- UITextViewDelegate
extension CreateProjectVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView){
        self.scrollView.setContentOffset(CGPoint(x: 0, y: self.keyboardHeight), animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView){
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

// MARK:- Server Bridge
extension CreateProjectVC {
    func createProjectWithParameters(parameters: Parameters){
        
        let token:String = UserDefaults.getToken() ?? ""
        
        if (token != ""){
            let bearer:String = "Bearer \(token)"
            
            let headers: HTTPHeaders = [
                "Authorization": bearer,
                "Accept": "application/json"]
            
            print(parameters)
            
            Alamofire.request(String(self.dev + "/projects"), method: .post, parameters: parameters, headers:headers).validate().responseJSON{ response in
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
