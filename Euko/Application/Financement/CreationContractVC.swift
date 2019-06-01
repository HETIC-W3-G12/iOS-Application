//
//  CreationContractVC.swift
//  Euko
//
//  Created by Victor Lucas on 14/03/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CreationContractVC: UIViewController {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var drawSpaceView: SHFSignatureView!
    
    @IBOutlet weak var contractTitle: UILabel!
    @IBOutlet weak var approuvedContent: UILabel!
    @IBOutlet weak var contractContent: UITextView!
    @IBOutlet weak var validateButton: UIButton!
    
    var isInvestor:Bool = true
    var signatureImage:UIImage = UIImage()
    var params:Parameters = [:]
    var offer:Offer?
    var projectPassed:Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawSpaceView.delegate = self
        self.clearButton.layer.borderWidth = 2
        self.clearButton.layer.borderColor = UIColor(red: 59/255, green: 84/255, blue: 213/255, alpha: 1).cgColor
        self.clearButton.roundBorder()
        self.validateButton.roundBorder()
        
        guard let user = UserDefaults.getUser() else { return }
        var project:Project!
        if !self.isInvestor {
            guard let tmp = self.offer?.project else { return }
            project = tmp
        } else {
            if self.projectPassed != nil {
                project = self.projectPassed
            }
            else { return }
        }
        
        
        let first = user.firstName
        let last = user.lastName
        let place = user.birthPlace
        let date = user.birthDate.toString()
        let laps = project.timeLaps!
        let inte = project.interests * 100
        let created = project.date.toString()
        let today = Date().toString()
        let price:Int = project.price
        let timelaps:Int = project.timeLaps!
        let interestAmount:Float = Float(price) * ((inte/100 * Float(timelaps)) / 12)
        let total:Float = Float(price) + interestAmount
        let mensualite:Float = total / Float(laps)

        let approuvedText = "Lu et approuvé le \(today)"
        self.approuvedContent.text = approuvedText
        

        var contractText = ""
        if (self.isInvestor == false){
            contractText = "Je soussigné \(first) \(last), né à \(place) le \(date), m'engage à régler la somme de \(total) euros.\n\nCette somme comprend ma demande de prêt initiale de \(price) euros ainsi que les intérêts de \(inte)%, soit \(interestAmount)\n\nJe m'engage à régler cette somme aux travers de mensualités de \(mensualite) euros durant \(laps) mois consécutifs, à compter du \(created)"
            
        } else {
            contractText = "Je soussigné \(first) \(last), né à \(place) le \(date), m'engage à régler la somme de \(total) euros.\n\nCette somme comprend ma demande de prêt initiale de \(price) euros ainsi que les intérêts de \(inte)%, soit \(String(format: "%.2f", interestAmount))\n\nJe m'engage à régler cette somme aux travers de mensualités de \(String(format: "%.2f", mensualite)) euros durant \(laps) mois consécutifs, à compter du \(created)"
        }
        self.contractContent.text = contractText

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        if (!self.isInvestor){
            self.validateButton.setTitle("Je m'engage", for: .normal)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        if (!self.isInvestor){
        }
    }

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func validateAction(_ sender: Any) {
        if (!self.isInvestor){
            self.acceptOffer()
        } else {
            self.financeProject()
        }
    }
    
    func acceptOffer() {
        let user:User = UserDefaults.getUser()!
        let bearer:String = "Bearer \(user.token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        guard let id = self.offer?.id else { return }
        
        guard let data = UIImage.resizeImage(image: self.signatureImage) else { return }
        let base64EncodedString = data.base64EncodedString()
        
        self.params = ["offer_id": id, "signature":base64EncodedString]
        
        headersRequest(params: self.params, endpoint: .acceptOffer, method: .post, header: headers, handler: {
            (success, json) in
            if (success){
                print(json ?? "Aucune valeur dans le JSON")
                self.showSingleAlertWithCompletion(title: "Vous avez bien accepté l'offre", message: "Les fonds vous seront trans;is sous peu. Attention un pret vous engage.", handler: {
                    _ in
                    self.navigationController?.popToRootViewController(animated: true)
                })
            } else {
                self.showSingleAlert(title: "Une erreur est survenue", message: "Veuillez réessayer")
            }
        })
    }
    
    func financeProject() {
        let user:User = UserDefaults.getUser()!
        let bearer:String = "Bearer \(user.token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        
        guard let data = UIImage.resizeImage(image: self.signatureImage) else { return }
        let base64EncodedString = data.base64EncodedString()
        
        self.params = ["project_id": self.projectPassed?.id ?? "", "signature":base64EncodedString]
            
        headersRequest(params: self.params, endpoint: .offers, method: .post, header: headers, handler: {
            (success, json) in
            if (success){
                print(json ?? "Aucune valeur dans le JSON")
                self.showSingleAlertWithCompletion(title: "En attente de validation", message: "Votre demande de financement à bien été envoyé et est en attente de validation par l'emprunteur", handler: {
                    _ in
                    self.navigationController?.popToRootViewController(animated: true)
                })
            } else {
                self.showSingleAlert(title: "Une erreur est survenue", message: "Veuillez réessayer")
            }
        })
    }
}

extension CreationContractVC: SHFSignatureProtocol {
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
