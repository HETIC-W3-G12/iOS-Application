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

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var askForMoneyButton: UIButton!
    @IBOutlet weak var nothingLabel: UILabel!
    
    let dev:String = "https://euko-api-staging-pr-34.herokuapp.com"
    let prod:String = "https://euko-api-staging.herokuapp.com"
    
    var projects:[Project] = []
        
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
        self.checkNumberOfProjects()
        self.tableView.reloadData()
    }
    
    func checkNumberOfProjects(){
        if (self.projects.count != 0){
            self.nothingLabel.isHidden = true
        } else {
            self.nothingLabel.isHidden = false
        }
    }

    //MARK override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        let insets = UIEdgeInsets(top: 4, left: 0, bottom: 72, right: 0)
        self.tableView.contentInset = insets

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.askForMoneyButton.roundBorder()
        self.shadowView.setSpecificShadow()
        self.shadowView.roundBorder()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false

        self.setProjects()
        self.turnAvctivityOff()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}


//MARK Server Bridge
extension ProjectListVC {
    @objc func setProjects(){
        
        if (self.projects.count > 0){
            self.turnAvctivityOn()
        }
        let params:Parameters = [:]
        
        defaultRequest(params: params, endpoint: endpoints.projects, method: .get, handler: {
            (success, jsonTab) in
            if (success){
                self.projects = []
                var i:Int = 0
                var json:JSON = jsonTab![i]
                while (json != JSON.null){
                    print(json)
                    let price = json["price"].int ?? 0
                    let interest = json["interests"].float ?? 0
                    let finalPrice = (interest * Float(price)) + Float(price)
                    let dateStr = json["createdDate"].string!.substring(to: 9)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date:Date = dateFormatter.date(from: dateStr)!
                    
                    let tmpProject = Project(id: json["id"].string ?? "",
                                             title: json["title"].string ?? "(Sans titre)",
                                             description: json["description"].string ?? "(Sans description)",
                                             state: json["state"].string ?? "",
                                             price: price,
                                             timeLaps: json["timeLaps"].int ?? 0,
                                             interests: interest,
                                             finalPrice: finalPrice,
                                             date: date)
                    
                    self.projects.append(tmpProject)
                    
                    i += 1
                    json = jsonTab![(i)]
                }
                self.turnAvctivityOff()
                self.orderProjectsByDate()
            } else {
                
            }
            
        })
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
            cell.smallTopConstraint.constant = 30
        } else {
            cell.topConstraint.constant = 25
            cell.smallTopConstraint.constant = 45
        }
        
        cell.priceLabel.text = String(format: "%d€", self.projects[indexPath.row].price)
        cell.infoLabel.text = String(format: "Remboursé en %d mois", self.projects[indexPath.row].timeLaps)
        cell.titleLabel.text = self.projects[indexPath.row].title
        cell.descriptionLabel.text = self.projects[indexPath.row].description
        
        cell.interestPriceLabel.text = String(format: "+%.f%%", self.projects[indexPath.row].interests * 100)
        
        let interest = (Float(self.projects[indexPath.row].price) * (Float(self.projects[indexPath.row].timeLaps) / 12)) / 10
        cell.interestPriceSecondLabel.text = String(format: "(%.2f€)", interest)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectVC
        vc.project = self.projects[indexPath.row]
        vc.isLoan = false
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
