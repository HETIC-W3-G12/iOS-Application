//
//  Dashboard.swift
//  Euko
//
//  Created by Victor Lucas on 11/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol DashboardDelegate {
    func reloadData()
}

class Dashboard {
    var offer:Offer?
    var delegate:DashboardDelegate?
    var offers:[Offer] = []
    
    init(offer:Offer? = nil, offers:[Offer] = []) {
        self.offer = offer
        self.offers = offers
    }
    
    func setProject(proj:Offer){
        self.offer = proj
    }
    
    func setOffers(off:[Offer]){
        self.offers = off
    }

    func orderOffersByDate() {
        self.offers.sort(by: {$0.project?.date.compare($1.project?.date ?? Date()) == .orderedDescending})
    }
    
    func fillDashboard() {
        let user:User = UserDefaults.getUser()!
        let bearer:String = "Bearer \(user.token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        let params:Parameters = [:]
        
        headersRequest(params: params, endpoint: .dashboard, method: .get, header: headers, handler: { (success, json) in
            if (success){
                print(json!)
                // Setting loan
                let tmpTopOffer = Offer()
                tmpTopOffer.id = json?["project"]["offers"][0]["id"].string ?? ""
                tmpTopOffer.state = json?["project"]["offers"][0]["state"].string?.getOfferState()
                tmpTopOffer.createdDate = json?["project"]["offers"][0]["createdDate"].string?.toDate()
                tmpTopOffer.investorSignature = UIImage() // json?["project"]["offers"]["id"].string ?? ""
                self.offer = tmpTopOffer
                
                let tmpProject:Project = Project()
                tmpProject.id = json?["project"]["id"].string ?? ""
                tmpProject.title = json?["project"]["title"].string ?? ""
                tmpProject.description = json?["project"]["description"].string ?? ""
                tmpProject.state = json?["project"]["state"].string ?? ""
                tmpProject.price = json?["project"]["price"].int ?? 0
                tmpProject.timeLaps = json?["project"]["timeLaps"].int ?? 0
                tmpProject.interests = json?["project"]["interests"].float ?? 0.01
                tmpProject.date = json?["project"]["createdDate"].string?.substring(to: 9).toDate() ?? Date()
                tmpProject.finalPrice = (Float(tmpProject.price) * tmpProject.interests)
                
                self.offer?.project = tmpProject
                
                // Settin offers
                var i = 0
                let jsonOffers:[JSON] = json?["offers"].array ?? []
                var tmpOffers:[Offer] = []
                while (i < jsonOffers.count){
                    let tmpProject:Project = Project()
                    
                    let tmpOffer:Offer = Offer()
                    tmpOffer.id = jsonOffers[i]["id"].string ?? ""
                    tmpOffer.createdDate = jsonOffers[i]["createdDate"].string?.toDate()
                    
                    tmpProject.id = jsonOffers[i]["project"]["id"].string ?? ""
                    tmpProject.title = jsonOffers[i]["project"]["title"].string ?? ""
                    tmpProject.description = jsonOffers[i]["project"]["description"].string ?? ""
                    tmpProject.state = jsonOffers[i]["project"]["state"].string ?? ""
                    tmpProject.price = jsonOffers[i]["project"]["price"].int ?? 0
                    tmpProject.timeLaps = jsonOffers[i]["project"]["timeLaps"].int ?? 0
                    tmpProject.interests = jsonOffers[i]["project"]["interests"].float ?? 0.01
                    tmpProject.date = jsonOffers[i]["project"]["createdDate"].string?.substring(to: 9).toDate() ?? Date()

                    tmpOffer.project = tmpProject
                    tmpOffers.append(tmpOffer)
                    i += 1
                }
                self.offers = tmpOffers
                self.delegate?.reloadData()
                //TODO: Alors, j'ai remplacé le tableu de projets par un tableau d'offers qui contient des projets, il faut donc maintenant supprimer l'ancien tableau (OK) et faire suivre les offers dans le dashboardVC qui lui ne gere que les projects
            }
            else {
                //TODO: Something
            }
        })
    }
}
