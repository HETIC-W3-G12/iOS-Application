//
//  ProjectListVC.swift
//  Euko
//
//  Created by Victor Lucas on 14/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class ProjectListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let dev:String = "https://euko-api-staging-pr-30.herokuapp.com"
    let prod:String = "https://euko-api-staging.herokuapp.com"
    
    var projects:[Project] = [Project(id: 0, title: "Velo", description: "Je n'ai pas les moyens pour une voiture c'est pourquoi j'ai besoin d'un velo pour aller au travail et eviter les retards des transports en commun.",
                                      state: "valid", price: 200, timeLaps: 3,
                                      interests: 0.17, finalPrice: (200 + (200 * (0.17/12) * 3)), date: Date(timeIntervalSince1970: 13)),
                              Project(id: 0, title: "Four combiné", description: "J'aimerai faire des plats dignes de ce noms pour mes enfants.",
                                      state: "valid", price: 350, timeLaps: 7,
                                      interests: 0.17, finalPrice: (350 + (350 * (0.17/12) * 7)), date: Date(timeIntervalSince1970: 14)),
                              Project(id: 0, title: "Nouvelles Balenciaga", description: "Elles coutent chères et je veux garder mes amies, donc en achetant ces chaussures j'espere qu'elles me continuerons de me consieder. :)",
                                      state: "valid", price: 630, timeLaps: 9,
                                      interests: 0.17, finalPrice: (630 + (630 * (0.17/12) * 9)), date: Date(timeIntervalSince1970: 15))]
    
    func turnAvctivityOn() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func turnAvctivityOff() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    func orderProjectsByDate() {
        self.projects.sort(by: {$0.date.compare($1.date) == .orderedDescending})
    }
    
    @IBAction func goToHomeAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK override
extension ProjectListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let HomeButton = UIBarButtonItem(title: "Menu", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.homeAction(_:)))
        self.navigationItem.leftBarButtonItem = HomeButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = true

        
        // To remove :
        //self.setProjects()
        self.turnAvctivityOff()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func homeAction(_ sender:UIBarButtonItem!)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK Server Bridge
extension ProjectListVC {
    @objc func setProjects(){
        
        if (self.projects.count > 0){
            self.turnAvctivityOn()
        }
        
        Alamofire.request(String(self.dev + "/projects"), method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                self.projects = []
                let jsonTab = JSON(value)
                var i:Int = 0
                var json:JSON = jsonTab[i]
                
                while (json != JSON.null){
                    print(json)
                    let id = json["id"].int ?? 0
                    let title = json["title"].string ?? "Aucun titre..."
                    let description = json["description"].string ?? "Aucune description..."
                    let price = json["price"].int ?? 0
                    let interest = json["interests"].float ?? 0
                    let state = json["state"].string!
                    let timeLaps = json["timeLaps"].int ?? 0
                    let dateStr = json["createdAt"].string!.substring(to: 9)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date:Date = dateFormatter.date(from: dateStr)!
                    
                    let finalPrice = (interest * Float(price)) + Float(price)
                    
                    let tmpProject = Project(id: id,
                                             title: title,
                                             description: description,
                                             state: state,
                                             price: price,
                                             timeLaps: timeLaps,
                                             interests: interest,
                                             finalPrice: finalPrice,
                                             date: date)
                    self.projects.append(tmpProject)
                    
                    i += 1
                    json = jsonTab[(i)]
                }
                self.turnAvctivityOff()
                self.orderProjectsByDate()
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


//MARK: TableViewDelegate TableViewDataSource
extension ProjectListVC: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "project_cell_identifier", for: indexPath) as! ProjectCell
        cell.selectionStyle = .none
        
        if (indexPath.row != 0){
            cell.topConstraint.constant = 10
        } else {
            cell.topConstraint.constant = 25
        }
        
        cell.titleLabel.text = self.projects[indexPath.row].title
        cell.descriptionLabel.text = self.projects[indexPath.row].description
        cell.triangleLabel.text = String(format: "+ %.f €",
                                         self.projects[indexPath.row].finalPrice - Float(self.projects[indexPath.row].price))
        
        let price:Int = self.projects[indexPath.row].price
        let timeLaps:Int = self.projects[indexPath.row].timeLaps
        cell.infoLabel.text = "\(price)€ pendant \(timeLaps) mois"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectVC
        vc.project = self.projects[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
