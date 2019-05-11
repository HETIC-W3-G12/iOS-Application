//
//  ProjectRecapVC.swift
//  Euko
//
//  Created by Victor Lucas on 05/04/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire

class ProjectRecapVC: UIViewController {

    @IBOutlet weak var totalTitle: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var askingMoneyLabel: UILabel!
    @IBOutlet weak var monthlyEngagementLabel: UILabel!
    @IBOutlet weak var monthNumberLabel: UILabel!
    @IBOutlet weak var interestNumberLabel: UILabel!
    
    var params:Parameters?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        let price:Int = self.params?["price"] as! Int
        let timelaps:Int = self.params?["timeLaps"] as! Int
        let interestAmount:Float = Float(price) * ((0.1 * Float(timelaps)) / 12)
        let total:Float = Float(price) + interestAmount
        
        self.totalTitle.text = String(format: "%.2f €", total)
        self.askingMoneyLabel.text = String(format: "Vous demandez %d€", price)
        self.monthlyEngagementLabel.text = String(format: "Vous allez rembourser %.2f€ par mois",
                                                  Float(total / Float(timelaps)))
        self.monthNumberLabel.text = String(format: "Pendant %d mois", timelaps)
        self.interestNumberLabel.text = String(format: "Avec %.2f€ d'intérêts", interestAmount)
        self.interestLabel.text = "(Taux d'intérêt 10%)"
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func engagementButton(_ sender: Any) {
    }
    
    @IBAction func askForMoneyAction(_ sender: Any) {
        if (self.params != nil){
            self.createProjectWithParameters(parameters: self.params!)
        }
    }
    
    
    func createProjectWithParameters(parameters: Parameters){
        let user:User = UserDefaults.getUser()!
        let token:String = user.token
        if (token != ""){
            let bearer:String = "Bearer \(token)"
            let headers: HTTPHeaders = [
                "Authorization": bearer,
                "Accept": "application/json"]
            
            headersRequest(params: parameters, endpoint: endpoints.projects, method: .post, header: headers, handler: {
                (success, json) in
                if (success){
                    self.navigationController?.popToRootViewController(animated: true)
                } else {
                    self.showSingleAlert(title: "Une erreure s'est produite", message: "Veuillez vérifier votre connexion internet.")
                }
            })
        }
    }

}
