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

protocol ServerBridgeDelegate {
    func defaultResponse(succed:Bool, json:JSON?)
}

extension ServerBridgeDelegate {
    func defaultResponse(succed:Bool, json:JSON?){ return }
}

public enum endpoints:String {
    case connexion = "/users/sign_in"
    case signup = "/users/sign_up"
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
                    self.delegate?.defaultResponse(succed: true, json: json)
                case .failure(let error):
                    print(error)
                    self.delegate?.defaultResponse(succed: false, json: nil)
                }
        }
    }
    
    public func signUpUser(params:Parameters, method:HTTPMethod){
        Alamofire.request(self.baseUrl + endpoints.signup.rawValue,
                          method: method,
                          parameters:params).validate().responseJSON
            { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.delegate?.defaultResponse(succed: true, json: json)
                case .failure(let error):
                    print(error)
                    self.delegate?.defaultResponse(succed: false, json: nil)
                }
        }
    }
}
