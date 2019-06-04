//
//  ContractDownloadVC.swift
//  Euko
//
//  Created by Victor Lucas on 01/06/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
    var isInvestor:Bool = false
    var owner:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.saveButton.roundBorder()
        self.saveButton.layer.borderWidth = 2
        self.saveButton.layer.borderColor = UIColor(red: 59/255, green: 84/255, blue: 213/255, alpha: 1).cgColor
        
        self.Asignature.image  = self.offer?.investorSignature
        self.Bsignature.image  = self.offer?.ownerSignature
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        self.content.text = "Chargement..."
        
        if (!self.isInvestor){
            self.getOfferDetails()
        } else {
            self.getProjectOwner()
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func updateContract() {
        guard let user = UserDefaults.getUser() else { return }
        guard let project = self.offer?.project else { return }
        
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
        let offerDate:String = self.offer?.createdDate?.toString() ?? ""
        
        if (self.isInvestor){
            let contractText = "\(ownerFirst) \(ownerLast), né à \(ownerBirthPlace) le \(ownerBirthDate), s'engage à régler la somme de \(total) euros à \(first) \(last) né à \(place) le \(date).\nCette somme comprend la demande de prêt initiale de \(price) euros ainsi que les intérêts de \(inte)%, soit \(interestAmount) euros.\n\(first) \(last), s'engage à régler cette somme aux travers de mensualités de \(mensualite) euros durant \(laps) mois consécutifs, à compter du \(created)"
            
            self.Aapprouved.text = "Lu et approuvé le \(created)"
            self.Bapprouved.text = "Lu et approuvé le \(offerDate)"
            self.content.text = contractText
            self.Afirstname.text = "\(ownerFirst) \(ownerLast)"
            self.Bfirstname.text = "\(first) \(last)"
        } else {
            let contractText = "\(first) \(last), né à \(place) le \(date), s'engage à régler la somme de \(total) euros à \(ownerFirst) \(ownerLast) né à \(ownerBirthPlace) le \(ownerBirthDate).\nCette somme comprend la demande de prêt initiale de \(price) euros ainsi que les intérêts de \(inte)%, soit \(interestAmount) euros.\n\(first) \(last), s'engage à régler cette somme aux travers de mensualités de \(mensualite) euros durant \(laps) mois consécutifs, à compter du \(created)"
            
            self.Aapprouved.text = "Lu et approuvé le \(created)"
            self.Bapprouved.text = "Lu et approuvé le \(offerDate)"
            self.content.text = contractText
            self.Afirstname.text = "\(first) \(last)"
            self.Bfirstname.text = "\(ownerFirst) \(ownerLast)"
        }
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        self.saveButton.isHidden = true
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
        
        self.showSingleAlertWithCompletion(title: "Votre contrat à bien été enregistré", message: "Vous le trouverez dans vos photos", handler: { _ in
            self.saveButton.isHidden = false
        })
    }
    
    func getProjectOwner(){
        let user:User = UserDefaults.getUser()!
        let bearer:String = "Bearer \(user.token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        let params:Parameters  = [:]
        guard let id:String = self.offer?.project?.id else { return }
        idRequest(params: params, endpoint: .projects, id: id, method: .get, header: headers, handler: {
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
        
        idRequest(params: params, endpoint: .offers, id: id, method: .get , header: headers, handler: { (success, json) in
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
}
