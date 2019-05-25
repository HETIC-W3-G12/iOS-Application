//
//  OnGoingVC.swift
//  Euko
//
//  Created by Victor Lucas on 07/04/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class OnGoingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var seeContractButton: UIButton!
    
    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    
    var offer:Offer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "OnGoingTVC", for: indexPath) as! OnGoingTVC
        if (indexPath.row % 2 == 0){
            cell.validatedImage.image = UIImage(named: "no_icone")
        }
        cell.titleLabel.text = String(format: "Row =  %d", indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
