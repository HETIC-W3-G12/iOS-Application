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

class CreationContractVC: UIViewController, SHFSignatureProtocol {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var drawSpaceView: SHFSignatureView!
    
    @IBOutlet weak var contractTitle: UILabel!
    @IBOutlet weak var approuvedContent: UILabel!
    @IBOutlet weak var contractContent: UITextView!
    @IBOutlet weak var validateButton: UIButton!
    
    var isNewProject:Bool = true
    var projectId:String = ""
    var signatureImage:UIImage = UIImage()
    var params:Parameters = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawSpaceView.delegate = self
        self.clearButton.layer.borderWidth = 2
        self.clearButton.layer.borderColor = UIColor(red: 59/255, green: 84/255, blue: 213/255, alpha: 1).cgColor
        self.clearButton.roundBorder()
        self.validateButton.roundBorder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        if (!self.isNewProject){
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if (!self.isNewProject){
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func validateAction(_ sender: Any) {
        if (self.isNewProject){
            //TODO: clean this
        } else {
            self.financeProject()
        }
    }
    
    func drawingSignature() {
    }
    
    func image(_ signature: UIImage?) {
        self.signatureImage = signature ?? UIImage()
    }

    @IBAction func clearAction(_ sender: Any) {
        self.drawSpaceView.clear()
        self.signatureImage = UIImage()
    }
    
    func financeProject() {
        let user:User = UserDefaults.getUser()!
        let bearer:String = "Bearer \(user.token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        self.params = ["project_id": self.projectId]
            
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
