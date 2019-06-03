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
    var owner:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawSpaceView.delegate = self
        self.clearButton.layer.borderWidth = 2
        self.clearButton.layer.borderColor = UIColor(red: 59/255, green: 84/255, blue: 213/255, alpha: 1).cgColor
        self.clearButton.roundBorder()
        self.validateButton.roundBorder()
        
        let today = Date().toString()
        let approuvedText = "Lu et approuvé le \(today)"
        self.approuvedContent.text = approuvedText
    
        let contractText = "Chargement..."
        self.contractContent.text = contractText

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        if (!self.isInvestor){
            self.validateButton.setTitle("Je m'engage", for: .normal)
            self.getOfferDetails()
        } else {
            self.getProjectOwner()
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
    
    func updateContract(){
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
        
        
        let ownerFirst = self.owner?.firstName.capitalized ?? ""
        let ownerLast = self.owner?.lastName.capitalized ?? ""
        let ownerBirthPlace = self.owner?.birthPlace.capitalized ?? ""
        let ownerBirthDate = self.owner?.birthDate.toString() ?? ""
        
        let first = user.firstName.capitalized
        let last = user.lastName.capitalized
        let place = user.birthPlace.capitalized
        let date = user.birthDate.toString()
        let laps = project.timeLaps!
        let inte = project.interests * 100
        let created = project.date.toString()
        let price:Int = project.price
        let timelaps:Int = project.timeLaps!
        let interestAmount:Float = Float(price) * ((inte/100 * Float(timelaps)) / 12)
        let total:Float = Float(price) + interestAmount
        let mensualite:String = String(format: "%.2f", total / Float(laps))

        if (self.isInvestor){
            let contractText = "\(ownerFirst) \(ownerLast), né à \(ownerBirthPlace) le \(ownerBirthDate), s'engage à régler la somme de \(total) euros à \(first) \(last) né à \(place) le \(date).\n\nCette somme comprend la demande de prêt initiale de \(price) euros ainsi que les intérêts de \(inte)%, soit \(interestAmount) euros.\n\n\(first) \(last), s'engage à régler cette somme aux travers de mensualités de \(mensualite) euros durant \(laps) mois consécutifs, à compter du \(created)"
            
            self.contractContent.text = contractText
        } else {
            let contractText = "\(first) \(last), né à \(place) le \(date), s'engage à régler la somme de \(total) euros à \(ownerFirst) \(ownerLast) né à \(ownerBirthPlace) le \(ownerBirthDate).\n\nCette somme comprend la demande de prêt initiale de \(price) euros ainsi que les intérêts de \(inte)%, soit \(interestAmount) euros.\n\n\(first) \(last), s'engage à régler cette somme aux travers de mensualités de \(mensualite) euros durant \(laps) mois consécutifs, à compter du \(created)"
            
            self.contractContent.text = contractText
        }
    }
    
    func getProjectOwner(){
        let user:User = UserDefaults.getUser()!
        let bearer:String = "Bearer \(user.token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        let params:Parameters  = [:]
        guard let id:String = self.projectPassed?.id else { return }
        ownerRequest(params: params, endpoint: .projects, projectId: id, method: .get, header: headers, handler: {
            (success, json) in
            if (success) {
                print(json ?? "Aucune valeur dans le JSON")
                let tmpUser:User = User()
                tmpUser.firstName = json?["user"]["firstname"].string ?? "..."
                tmpUser.lastName = json?["user"]["lastname"].string ?? "..."
                tmpUser.birthDate = json?["user"]["birthdate"].string?.toDate() ?? Date()
                tmpUser.birthPlace = json?["user"]["birthplace"].string ?? "..."
                self.owner = tmpUser
                self.updateContract()
            } else {
                self.showSingleAlert(title: "Une erreur est survenue", message: "Veuillez réessayer")
            }
        })
    }
    
    func getOfferDetails(){
        
        let user:User = UserDefaults.getUser()!
        let bearer:String = "Bearer \(user.token)"
        let headers:HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        let params:Parameters = [:]
        
        guard let id:String = self.offer?.id else { return }
        
        deadlineRequest(params: params, endpoint: .offers, offerId: id, method: .get , header: headers, handler: { (success, json) in
            if (success){
                print(json!)
                
                guard let json = json else { return }
                let tmpUser = User(id: json["project"]["user"]["id"].string ?? "...",
                                   token: "",
                                   email: "",
                                   password: "",
                                   firstName: json["user"]["firstname"].string ?? "...",
                                   lastName: json["user"]["lastname"].string ?? "...",
                                   address: json["user"]["adress"].string ?? "...",
                                   postCode: 0,
                                   city: json["user"]["city"].string ?? "...",
                                   birthPlace: json["user"]["birthplace"].string ?? "...",
                                   birthDate: json["user"]["birthdate"].string?.toDate() ?? Date())
                self.owner = tmpUser
                self.updateContract()
            } else {
                self.showSingleAlert(title: "Une erreur est survenue", message: "Veuillez réessayer")
            }
        })
    }
    
    func acceptOffer() {
        let user:User = UserDefaults.getUser()!
        let bearer:String = "Bearer \(user.token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        guard let id = self.offer?.id else { return }
        
        guard let data = UIImage.resizeImage(image: self.signatureImage) else {
            self.showSingleAlert(title: "Important", message: "Veuillez signer le contrat avant de vous engager")
            return
        }
        let base64EncodedString = data.base64EncodedString()
        
        self.params = ["offer_id": id, "signature":base64EncodedString]
        
        headersRequest(params: self.params, endpoint: .acceptOffer, method: .post, header: headers, handler: {
            (success, json) in
            if (success){
                print(json ?? "Aucune valeur dans le JSON")
                self.showSingleAlertWithCompletion(title: "Vous avez bien accepté l'offre", message: "Les fonds vous arriveront sous peu. Attention vous vous êtes engagé à rembourser.", handler: {
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
        
        guard let data = UIImage.resizeImage(image: self.signatureImage) else {
            self.showSingleAlert(title: "Important", message: "Veuillez signer le contrat avant de vous engager")
            return
        }
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
