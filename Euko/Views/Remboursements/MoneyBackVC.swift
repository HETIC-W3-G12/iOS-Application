//
//  MoneyBackVC.swift
//  Euko
//
//  Created by Victor Lucas on 21/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class MoneyBackVC: UIViewController {

    @IBOutlet weak var progressAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var totalProgressView: UIView!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var projectListButton: UIButton!
    
    let loan:Project = Project(id: 0, title: "test loan", description: "loan test", state: "valid", price: 400, timeLaps: 12, interests: 0.1, finalPrice: 440, date: Date(timeIntervalSince1970: 16))
    
    let projects:[Project] = [Project(id: 0, title: "test project", description: "testdesc", state: "valid", price: 300, timeLaps: 12, interests: 0.1, finalPrice: 330, date: Date(timeIntervalSince1970: 13)),
                              Project(id: 0, title: "test project 2", description: "testdesc 2", state: "valid", price: 600, timeLaps: 12, interests: 0.1, finalPrice: 660, date: Date(timeIntervalSince1970: 14)),
                              Project(id: 0, title: "test project 3", description: "testdesc 3", state: "valid", price: 100, timeLaps: 12, interests: 0.1, finalPrice: 110, date: Date(timeIntervalSince1970: 15))]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.titleLabel.text = self.loan.title
        self.totalAmount.text = String(format: "sur %.2f", self.loan.finalPrice)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func seeMoreAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectVC
        vc.project = self.loan
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func projectListAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension MoneyBackVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MoneyBackCell", for: indexPath) as! MoneyBackCell
        
        cell.titleLabel.text = self.projects[indexPath.row].title
        cell.totalAmountLabel.text = String(format: "sur %.2f", self.projects[indexPath.row].finalPrice)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectVC
        vc.project = self.projects[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
