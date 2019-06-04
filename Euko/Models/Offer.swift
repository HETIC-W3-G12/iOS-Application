//
//  Offer.swift
//  Euko
//
//  Created by Victor Lucas on 24/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum OfferState:String {
    case waiting = "waiting"
    case refused = "refused"
    case accepted = "running"
}

protocol OfferDelegate {
    func reloadData()
    func couldNotGetDeadlines()
}

class Offer {
    var id:String?
    var state:OfferState?
    var createdDate:Date?
    var investorSignature:UIImage?
    var ownerSignature:UIImage?
    var project:Project?
    
    var delegate:OfferDelegate?
    
    var deadlines:[Deadline] = []
    
    init(id:String? = "", state:OfferState? = OfferState.waiting, createdDate:Date? = Date(), investorSignature:UIImage? = nil, ownerSignature:UIImage? = nil, project:Project? = nil){
        self.id = id
        self.state = state
        self.createdDate = createdDate
        self.investorSignature = investorSignature
        self.ownerSignature = ownerSignature
    }
    
    func fillDeadlines() {
        let user:User = UserDefaults.getUser()!
        let bearer:String = "Bearer \(user.token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        let params:Parameters = [:]
        
        deadlineRequest(params: params, endpoint: .offers, offerId: self.id ?? "", method: .get , header: headers, handler: { (success, json) in
            if (success){
                print(json!)
                
                guard let json = json else {
                    self.delegate?.couldNotGetDeadlines()
                    return
                }
                
                self.setOwnerImage(json: json)
                self.setInvestorImage(json: json)
                
                var i:Int = 0
                var tmpJson:[JSON] = json["refunds"].array ?? []
                self.deadlines = []
                while (i < tmpJson.count){
                    let tmp:Deadline = Deadline()
                    
                    tmp.state = tmpJson[i]["state"].string?.toDeadlineState()
                    tmp.createdDate = tmpJson[i]["createdDate"].string?.toDate()
                    tmp.dueDate = tmpJson[i]["dueDate"].string?.toDate()
                    tmp.amout = tmpJson[i]["amount"].double
                    tmp.id = tmpJson[i]["id"].string
                    
                    self.deadlines.append(tmp)
                    i += 1
                }
                self.delegate?.reloadData()
            } else {
                self.delegate?.couldNotGetDeadlines()
            }
        })
    }
    
    func setInvestorImage(json:JSON){
        guard let bufferData = json["signature_investor"]["Body"]["data"].array else { return }
        let bytes = bufferData.compactMap { $0.uInt8 }
        let imageData = NSData(bytes: bytes, length: bytes.count)
        let data = Data(referencing: imageData)
        
//        let base = json["signature_investor"]["Body"]["data"].string ?? ""
//        let decodedData = Data(base64Encoded: base)
//        self.investorSignature = UIImage(data: decodedData ?? Data())
        
        self.investorSignature = UIImage(data: data)
    }
    
    func setOwnerImage(json:JSON){
        guard let bufferData = json["signature_owner"]["Body"]["data"].array else { return }
        let bytes = bufferData.compactMap { $0.uInt8 }
        let imageData = NSData(bytes: bytes, length: bytes.count)
        let data = Data(referencing: imageData)
        
        self.ownerSignature = UIImage(data: data)
    }
}
