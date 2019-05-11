//
//  Euko.swift
//  Euko
//
//  Created by Victor Lucas on 11/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Euko {
    func getDashboard() -> Dashboard {
        let dash = Dashboard()
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
                
                dash.setProject(proj: tmpProject)
                
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
                dash.setOffers(off: tmpOffers)
            }
            else {
                //TODO: Something
            }
        })
        
        return dash
    }
}
