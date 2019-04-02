//
//  ServerBridge.swift
//  Euko
//
//  Created by Victor Lucas on 02/04/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public enum endpoints:String {
    case connexion = "/users/sign_in"
}

protocol ServerBridgeDelegate {
    func connectionResponse(succed:Bool, json:JSON?)
}

class ServerBridge {
    
    let baseUrl:String = ""
    var delegate:ServerBridgeDelegate?
    
    public func defaultRequest(totalURL:String, params:Parameters, method:HTTPMethod){
        Alamofire.request(totalURL,
                          method: method,
                          parameters:params).validate().responseJSON
            { response in
                // call delegate here
        }
    }
    public func connectUser(params:Parameters, method:HTTPMethod){
        Alamofire.request(self.baseUrl + endpoints.connexion.rawValue,
                          method: method,
                          parameters:params).validate().responseJSON
            { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.delegate?.connectionResponse(succed: true, json: json)
                case .failure(let error):
                    print(error)
                    self.delegate?.connectionResponse(succed: false, json: nil)
                }
        }
    }
}
