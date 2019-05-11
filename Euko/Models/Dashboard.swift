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

class Dashboard {
    var project:Project?
    var offers:[Project]
    
    init(project:Project? = nil, offers:[Project] = []) {
        self.project = project
        self.offers = offers
    }
    
    func setProject(proj:Project){
        self.project = proj
    }
    
    func setOffers(off:[Project]){
        self.offers = off
    }

    func orderOffersByDate() {
        self.offers.sort(by: {$0.date.compare($1.date) == .orderedDescending})
    }
    
    func fillDashboard() {
        let params:Parameters = [:]
        defaultRequest(params: params, endpoint: .dashboard, method: .get, handler: { (success, json) in
            if (success){
                // Setting loan
                let tmpProject:Project = Project()
                
                tmpProject.id = json?["projects"]["id"].string ?? ""
                tmpProject.title = json?["projects"]["title"].string ?? ""
                tmpProject.description = json?["projects"]["description"].string ?? ""
                tmpProject.state = json?["projects"]["state"].string ?? ""
                tmpProject.price = json?["projects"]["price"].int ?? 0
                tmpProject.timeLaps = json?["projects"]["timeLaps"].int ?? 0
                tmpProject.interests = json?["projects"]["interests"].float ?? 0.01
                tmpProject.date = json?["projects"]["createdDate"].string?.substring(to: 9).toDate() ?? Date()
                
                self.project = tmpProject
                
                // Settin offers
                var i = 0
                var tmpOffers:[Project] = []
                let jsonOffers:[JSON] = json?["offers"].array ?? []
                while (jsonOffers[i] != JSON.null){
                    let tmpProject:Project = Project()
                    
                    tmpProject.id = jsonOffers[i]["project"]["id"].string ?? ""
                    tmpProject.title = jsonOffers[i]["project"]["title"].string ?? ""
                    tmpProject.description = jsonOffers[i]["project"]["description"].string ?? ""
                    tmpProject.state = jsonOffers[i]["project"]["state"].string ?? ""
                    tmpProject.price = jsonOffers[i]["project"]["price"].int ?? 0
                    tmpProject.timeLaps = jsonOffers[i]["project"]["timeLaps"].int ?? 0
                    tmpProject.interests = jsonOffers[i]["project"]["interests"].float ?? 0.01
                    tmpProject.date = jsonOffers[i]["project"]["createdDate"].string?.substring(to: 9).toDate() ?? Date()
                    
                    tmpOffers.append(tmpProject)
                    i += 1
                }
                self.offers = tmpOffers
            }
            else {
                //TODO: Something
            }
        })
    }
}
