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
    case uploadFace = "/users/face_photo"
    case uploadIdentity = "/users/identity"
    case connexion = "/users/sign_in"
    case signup = "/users/sign_up"
    case dashboard = "/users/dashboard"
    case projects = "/projects"
    case offers = "/offers"
    case acceptOffer = "/offers/accept"
    case refuseOffer = "/offers/refuse"
}

class ServerBridge {
    //static let baseUrl:String = "https://euko-api-staging-pr-42.herokuapp.com"
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

func deadlineRequest(params:Parameters, endpoint:endpoints, offerId:String, method:HTTPMethod,
                     header:HTTPHeaders, handler: @escaping ((_ success: Bool, _ json:JSON?) -> Void)){
    print("URL : " + ServerBridge.baseUrl + endpoint.rawValue + "/\(offerId)")
    Alamofire.request(ServerBridge.baseUrl + endpoint.rawValue + "/\(offerId)",
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
