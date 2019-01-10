//
//  MoneyBackVC.swift
//  Euko
//
//  Created by Victor Lucas on 21/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class MoneyBackVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var showButton: UIButton!
    
    var isShown:Bool = false
    let tmpEcheances:[String] = ["Mois 1 = 75€", "Mois 3 = 75€", "Mois 3 = 75€", "Mois 4 = 75€", "Mois 5 = 75€", "Mois 6 = 75€", "Mois 7 = 50€"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hideTableView()
        self.tableView.separatorColor = UIColor.white
    }
    
    func showTableView () {
        self.tableHeightConstraint.constant = 350
        self.isShown = true
    }
    
    func hideTableView () {
        self.tableHeightConstraint.constant = 0
        self.isShown = false
    }
    
    @IBAction func showAction(_ sender: Any) {
        if (self.isShown){
            self.hideTableView()
        } else {
            self.showTableView()
        }
    }
}

extension MoneyBackVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tmpEcheances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MoneyBackCell", for: indexPath) as UITableViewCell
        
        cell.textLabel!.text = "\(self.tmpEcheances[indexPath.row])"
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.red.cgColor

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if (cell.accessoryType == .checkmark){
                cell.accessoryType = .none
            }
            else {
                cell.accessoryType = .checkmark
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
