//
//  ProjectListVC.swift
//  Euko
//
//  Created by Victor Lucas on 14/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class ProjectListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var fakeProjects:[Project] = []
    
    func setFakeProjects(){
        self.fakeProjects = [Project(uid: "uid1",
                                     user_uid: "user_uid1",
                                     title: "Besoin d'argent",
                                     description: "Mon dealer a augmenté ses prix, stp aide moi",
                                     price: 400,
                                     timeLaps: 6,
                                     interests: 0.05,
                                     finalPrice: 410.0),
                             
                             Project(uid: "uid2",
                                     user_uid: "user_uid2",
                                     title: "Pour acheter un lave-linge",
                                     description: "C'est ultra-urgent, il me faut un nouveau lave-linge ! L'autre ne convient plus à ma femme, il en faut donc un avec un très fort essorage pour que ma femme soit satisfaite de nouveau.",
                                     price: 350,
                                     timeLaps: 4,
                                     interests: 0.035,
                                     finalPrice: 354.08),
                             
                             Project(uid: "uid3",
                                     user_uid: "user_uid3",
                                     title: "Aidez moi",
                                     description: "Macron a baissé mes allocations, j'ai 5 enfants et je suis seule au foyer car mon homme est en prison pour viol et agressions à mains armés. J'ai besoin de plus d'argent pour pouvoir faire mon shopping, en plus c'est bientot le BlackFriday vite aidez moi svp.",
                                     price: 760,
                                     timeLaps: 12,
                                     interests: 0.13,
                                     finalPrice: 858.8)]
    }
}

//MARK override
extension ProjectListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setFakeProjects()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let HomeButton = UIBarButtonItem(title: "Menu", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.homeAction(_:)))
        self.navigationItem.leftBarButtonItem = HomeButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        return self.fakeProjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "project_cell_identifier", for: indexPath) as! ProjectCell
        cell.selectionStyle = .none
        
        cell.titleLabel.text = self.fakeProjects[indexPath.row].title
        cell.descriptionLabel.text = self.fakeProjects[indexPath.row].description
        
        let price:Int = self.fakeProjects[indexPath.row].price
        let timeLaps:Int = self.fakeProjects[indexPath.row].timeLaps
        cell.infoLabel.text = "\(price)€ - \(timeLaps) mois"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectVC
        vc.project = self.fakeProjects[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
