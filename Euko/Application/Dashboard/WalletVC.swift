//
//  WalletVC.swift
//  Euko
//
//  Created by Victor Lucas on 15/03/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WalletVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DashboardDelegate {

    @IBOutlet weak var profileScrollView: UIScrollView!

    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var topSeeMoreButton: UIButton!
    @IBOutlet weak var topTimeStampLabel: UILabel!
    @IBOutlet weak var topGlobalProgressView: UIView!
    @IBOutlet weak var topOnGoingProgressView: UIView!
    @IBOutlet weak var topTotalAmount: UILabel!
    @IBOutlet weak var topCurrentAmount: UILabel!
    @IBOutlet weak var topOnGoingTrailingConstraint: NSLayoutConstraint!

    @IBOutlet weak var bottomTableView: UITableView!
    @IBOutlet weak var bottomTableViewHeightConstraint: NSLayoutConstraint!
    

    var dashboard:Dashboard = Dashboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bottomTableView.delegate = self
        self.bottomTableView.dataSource = self
        self.bottomTableView.reloadData()
        
        self.topViewContainer.setSpecificShadow()
        self.topViewContainer.roundBorder(radius: 5)
        self.setupTopCell()
        
        self.dashboard.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        self.dashboard.fillDashboard()
        self.dashboard.orderOffersByDate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    func reloadData(){
        self.bottomTableView.reloadData()
    }
    
    func setupTopCell () {
        if self.dashboard.project != nil {
            let rand = Float.random(in: 1 ..< 12)
            let loan = self.dashboard.project ?? Project()
            
            self.topTitleLabel.text = loan.title
            self.topTotalAmount.text = String(format: "sur %.f€", loan.finalPrice)
            self.topCurrentAmount.text = String(format: "%.2f€", loan.finalPrice / rand)
            
            let maxPrice:CGFloat = CGFloat(loan.finalPrice)
            let minPrice:CGFloat = CGFloat(loan.finalPrice / rand)
            let percentagePrice:CGFloat = CGFloat(minPrice * 100) / CGFloat((maxPrice == 0) ? 1 : maxPrice)
            
            let width:CGFloat = self.topGlobalProgressView.frame.width
            let newWidth:CGFloat = CGFloat(percentagePrice * width) / 100
            let newTrailing:CGFloat = CGFloat(width - newWidth)
            
            self.topOnGoingTrailingConstraint.constant = newTrailing
            self.topViewContainer.isHidden = false
        } else {
            self.topViewContainer.isHidden = true
        }

    }
    
    @IBAction func seeMore(_ sender: Any) {
        //TODO: Will load the contract
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectVC
        vc.project = self.dashboard.project ?? Project()
        vc.isLoan = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dashboard.offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.bottomTableView.dequeueReusableCell(withIdentifier: "MoneyBackCell", for: indexPath) as! MoneyBackCell
        cell.containerView.setSpecificShadow()
        cell.containerView.roundBorder(radius: 5)
        cell.project = self.dashboard.offers[indexPath.row]    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.bottomTableViewHeightConstraint.constant = CGFloat(150 * self.dashboard.offers.count)
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.bottomTableView.deselectRow(at: indexPath, animated: true)
                
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectVC
        vc.project = self.dashboard.offers[indexPath.row]
        vc.isLoan = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
