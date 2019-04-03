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
    case signup = "/users/sign_up"
    case projects = "/projects"
}

class ServerBridge {
    
    static let baseUrl:String = "https://euko-api-staging.herokuapp.com"
}

func defaultRequest(params:Parameters, endpoint:endpoints, method:HTTPMethod, handler: @escaping ((_ success: Bool, _ json:JSON?) -> Void)){
    print("URL : " + ServerBridge.baseUrl + endpoint.rawValue)
    Alamofire.request(ServerBridge.baseUrl + endpoint.rawValue,
                      method: method,
                      parameters:params).validate().responseJSON
        { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                handler(true, json)
            case .failure(let error):
                print(error)
                handler(false, nil)
            }
    }
}

func headersRequest(params:Parameters, endpoint:endpoints, method:HTTPMethod,
                   header:HTTPHeaders, handler: @escaping ((_ success: Bool, _ json:JSON?) -> Void)){
    print("URL : " + ServerBridge.baseUrl + endpoint.rawValue)
    Alamofire.request(ServerBridge.baseUrl + endpoint.rawValue,
                      method: method,
                      parameters:params,
                      headers:header).validate().responseJSON
        { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                handler(true, json)
            case .failure(let error):
                print(error)
                handler(false, nil)
            }
    }
}
