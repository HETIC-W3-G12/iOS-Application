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
    
    var projects:[Project] = []
    
    func setProjects(){
        Alamofire.request("https://euko-api-staging.herokuapp.com/projects", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
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
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK override
extension ProjectListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let HomeButton = UIBarButtonItem(title: "Menu", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.homeAction(_:)))
        self.navigationItem.leftBarButtonItem = HomeButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setProjects()
        super.viewWillAppear(animated)
    }
    
    @objc func homeAction(_ sender:UIBarButtonItem!)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        cell.titleLabel.text = self.projects[indexPath.row].title
        cell.descriptionLabel.text = self.projects[indexPath.row].description
        
        let price:Int = self.projects[indexPath.row].price
        let timeLaps:Int = self.projects[indexPath.row].timeLaps
        cell.infoLabel.text = "\(price)€ - \(timeLaps) mois"
        
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
