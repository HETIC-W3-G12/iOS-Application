//
//  Inscription.swift
//  Euko
//
//  Created by Victor Lucas on 16/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol InscriptionDelegate {
    func uploadsFinished()
    func errorOnUpload()
    func errorOnImages()
}

class Inscription {
    var delegate:InscriptionDelegate?
    var user:User? = nil
    var inscriptionPassword:String? = nil
    var inscriptionEmail:String? = nil
    var identityImage:UIImage? = nil
    var selfieImage:UIImage? = nil
    
    func uploadImages() {
        guard let token = self.user?.token else {
            self.delegate?.errorOnUpload()
            return
        }
        let bearer:String = "Bearer \(token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        
        guard let data = UIImage.resizeImage(image: self.identityImage) else {
            self.delegate?.errorOnImages()
            return
        }
        let base64EncodedString = data.base64EncodedString()
        let parameters:Parameters = ["file": base64EncodedString]
        headersRequest(params: parameters, endpoint: .uploadIdentity, method: .post, header: headers, handler: { (success, json) in
            if (success){
                self.uploadFace()
            }
        })

        
    }
    
    private func uploadFace() {
        guard let token = self.user?.token else {
            self.delegate?.errorOnUpload()
            return
        }
        let bearer:String = "Bearer \(token)"
        let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
        
        guard let data = UIImage.resizeImage(image: self.selfieImage) else {
            self.delegate?.errorOnImages()
            return
        }
        let base64EncodedString = data.base64EncodedString()
        let parameters:Parameters = ["file": base64EncodedString]
        headersRequest(params: parameters, endpoint: .uploadFace, method: .post, header: headers, handler: { (success, json) in
            if (success){
                self.delegate?.uploadsFinished()
            }
        })
    }
}
