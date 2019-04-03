//
//  TestUploadVC.swift
//  Euko
//
//  Created by Victor Lucas on 02/04/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TestUploadVC: UIViewController {

    @IBOutlet weak var imageback: UIImageView!
    @IBOutlet weak var buttonici: UIButton!
    @IBOutlet weak var recuperation: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    @IBAction func uploadfile(_ sender: Any) {
        self.test2()
    }
    
    
    @IBAction func recupfromserver(_ sender: Any) {
        let parameters:Parameters = [:]
        
        
        Alamofire.request("https://euko-api-staging-pr-40.herokuapp.com/file-test/94484cc0-5558-11e9-a5d8-ddced47f5781-maillot.jpg",
                          method: .get,
                          parameters:parameters).validate().responseJSON
            { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json["Body"])
                    let bufferData = json["Body"]["data"].array
                    let bytes = bufferData!.compactMap { $0.uInt8 }
                    let imageData = NSData(bytes: bytes, length: bytes.count)
                    let data = Data(referencing: imageData)
                    
                    self.imageback.image = UIImage(data: data)
                case .failure(let error):
                    print(error)
                }
        }
        
    }
    
    func test2() {
        // maillot.jpg no more in repo
        if let fileURL = Bundle.main.url(forResource: "maillot", withExtension: "jpg") {
            do {
                let data = try Data(contentsOf: fileURL)
                let base64EncodedString = data.base64EncodedString()
                
                let parameters:Parameters = ["file":base64EncodedString, "name":"maillot.jpg"]
                
                
                Alamofire.request("https://euko-api-staging-pr-40.herokuapp.com/file-test",
                                  method: .post,
                                  parameters:parameters).validate().responseJSON
                    { response in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            print(json)
                        case .failure(let error):
                            print(error)
                        }
                }
            } catch let error {print(error)}
        }
    }
}
