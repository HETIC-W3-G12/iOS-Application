//
//  WalletVC.swift
//  Euko
//
//  Created by Victor Lucas on 15/03/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class WalletVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var topSeeMoreButton: UIButton!
    @IBOutlet weak var topTimeStampLabel: UILabel!
    @IBOutlet weak var topGlobalProgressView: UIView!
    @IBOutlet weak var topOnGoingProgressView: UIView!
    @IBOutlet weak var topTotalAmount: UILabel!
    @IBOutlet weak var topCurrentAmount: UILabel!
    @IBOutlet weak var bottomTableView: UITableView!
    @IBOutlet weak var bottomTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topOnGoingTrailingConstraint: NSLayoutConstraint!

    let myLoan:Project = Project(id: 0, title: "Vélo", description: "J'ai besoin d'un vélo pour aller au travail tous les jours sans avoir a prendre les transports en commun ni m'acheter une voiture.", state: 1, price: 350, timeLaps: 12, interests: 0.1, finalPrice: 385, date: Date(timeIntervalSince1970: 16))
    
    let myFinancements:[Project] = [Project(id: 0, title: "Balenciaga", description: "J'en ai vraiment trop besoin !", state: 1, price: 300, timeLaps: 12, interests: 0.1, finalPrice: 330, date: Date(timeIntervalSince1970: 13)),
                                    Project(id: 0, title: "Projet de test 2", description: "Description de test 2", state: 1, price: 100, timeLaps: 12, interests: 0.1, finalPrice: 110, date: Date(timeIntervalSince1970: 15)),
                                    Project(id: 0, title: "Projet de test 3", description: "Description de test 2", state: 1, price: 100, timeLaps: 12, interests: 0.1, finalPrice: 760, date: Date(timeIntervalSince1970: 15)),
                                    Project(id: 0, title: "Projet de test 4", description: "Description de test 2", state: 1, price: 100, timeLaps: 12, interests: 0.1, finalPrice: 480, date: Date(timeIntervalSince1970: 15)),
                                    Project(id: 0, title: "Projet de test 5", description: "Description de test 2", state: 1, price: 100, timeLaps: 12, interests: 0.1, finalPrice: 200, date: Date(timeIntervalSince1970: 15)),
                                    Project(id: 0, title: "Projet de test 6", description: "Description de test 3", state: 1, price: 100, timeLaps: 12, interests: 0.1, finalPrice: 510, date: Date(timeIntervalSince1970: 15))]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bottomTableView.delegate = self
        self.bottomTableView.dataSource = self
        
        self.bottomTableView.reloadData()
        self.topViewContainer.setSpecificShadow()
        self.topViewContainer.roundBorder(radius: 5)
        
        self.setupTopCell()
    }
    
    func setupTopCell () {
        //TODO: replace the rand with the current amount refounded
        let rand = Float.random(in: 1 ..< 12)
        
        
        self.topTitleLabel.text = self.myLoan.title
        self.topTotalAmount.text = String(format: "sur %.f€", self.myLoan.finalPrice)
        self.topCurrentAmount.text = String(format: "%.2f€", self.myLoan.finalPrice / rand)
        
        let maxPrice:CGFloat = CGFloat(self.myLoan.finalPrice)
        let minPrice:CGFloat = CGFloat(self.myLoan.finalPrice / rand)
        let percentagePrice:CGFloat = CGFloat(minPrice * 100) / CGFloat((maxPrice == 0) ? 1 : maxPrice)
        
        let width:CGFloat = self.topGlobalProgressView.frame.width
        let newWidth:CGFloat = CGFloat(percentagePrice * width) / 100
        let newTrailing:CGFloat = CGFloat(width - newWidth)
        
        self.topOnGoingTrailingConstraint.constant = newTrailing
    }
    
    @IBAction func seeMore(_ sender: Any) {
        //TODO: Will load the contract
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectVC
        vc.project = self.myLoan
        vc.isLoan = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myFinancements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.bottomTableView.dequeueReusableCell(withIdentifier: "MoneyBackCell", for: indexPath) as! MoneyBackCell
        cell.containerView.setSpecificShadow()
        cell.containerView.roundBorder(radius: 5)
        
        //TODO: replace the rand with the current amount refounded
        let rand = Float.random(in: 1 ..< 12)
        cell.titleLabel.text = self.myFinancements[indexPath.row].title
        cell.moneyBackLabel.text = String(format: "%.2f€",
                                          ceil(self.myFinancements[indexPath.row].finalPrice / rand))
        cell.totalAmountLabel.text = String(format: "sur %.f€",
                                            ceil(self.myFinancements[indexPath.row].finalPrice))
        
        let maxPrice:CGFloat = CGFloat(self.myFinancements[indexPath.row].finalPrice)
        let minPrice:CGFloat = CGFloat(self.myFinancements[indexPath.row].finalPrice / rand)
        let percentagePrice:CGFloat = CGFloat(minPrice * 100) / CGFloat((maxPrice == 0) ? 1 : maxPrice)
        
        let width:CGFloat = cell.totalView.frame.width
        let newWidth:CGFloat = CGFloat(percentagePrice * width) / 100
        let newTrailing:CGFloat = CGFloat(width - newWidth)
        
        cell.progressViewTrailing.constant = newTrailing
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.bottomTableViewHeightConstraint.constant = CGFloat(150 * self.myFinancements.count)
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.bottomTableView.deselectRow(at: indexPath, animated: true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectVC
        vc.project = self.myFinancements[indexPath.row]
        vc.isLoan = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
