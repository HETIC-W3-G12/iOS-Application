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
        
        
        self.dashboard.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
        self.dashboard.fillDashboard()
        self.dashboard.orderOffersByDate()
        self.reloadData()
        self.setupTopCell()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    func reloadData(){
        self.setupTopCell()
        self.bottomTableView.reloadData()
    }
    
    func hideTopElements() {
        self.topGlobalProgressView.isHidden = true
        self.topOnGoingProgressView.isHidden = true
        self.topCurrentAmount.isHidden = true
        self.topTotalAmount.isHidden = true
        self.topTimeStampLabel.isHidden = true
    }
    
    func showTopElemets(){
        self.topTimeStampLabel.isHidden = false
        self.topGlobalProgressView.isHidden = false
        self.topOnGoingProgressView.isHidden = false
        self.topCurrentAmount.isHidden = false
        self.topTotalAmount.isHidden = false
    }
    
    func setupTopCell () {
        if self.dashboard.offer?.project != nil {
            
            guard let loan = self.dashboard.offer?.project else { return }
            if loan.state == "waiting" {
                self.topSeeMoreButton.setTitle("Accepter / Refuser", for: .normal)
                self.topTitleLabel.text = loan.title
                self.hideTopElements()
            } else if loan.state == "running" {
                self.showTopElemets()
                self.topSeeMoreButton.setTitle("Voir plus", for: .normal)
                self.topSeeMoreButton.titleLabel?.textAlignment = NSTextAlignment.right
                self.topTitleLabel.text = loan.title
                self.topTotalAmount.text = String(format: "sur %.f€", loan.finalPrice)
                self.topCurrentAmount.text = String(format: "%.2f€", loan.finalPrice / 1)
                
                let maxPrice:CGFloat = CGFloat(loan.finalPrice)
                let minPrice:CGFloat = CGFloat(loan.finalPrice / 1)
                let percentagePrice:CGFloat = CGFloat(minPrice * 100) / CGFloat((maxPrice == 0) ? 1 : maxPrice)
                
                let width:CGFloat = self.topGlobalProgressView.frame.width
                let newWidth:CGFloat = CGFloat(percentagePrice * width) / 100
                let newTrailing:CGFloat = CGFloat(width - newWidth)
                
                self.topOnGoingTrailingConstraint.constant = newTrailing
            } else {
                self.topViewContainer.isHidden = true
                return
            }
            
            
            self.topViewContainer.isHidden = false
        } else {
            self.topViewContainer.isHidden = true
        }

    }
    
    @IBAction func seeMore(_ sender: Any) {
        guard let loan = self.dashboard.offer?.project else { return }
        if loan.state == "waiting" {
            self.tripleChoice()
        } else if loan.state == "running" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnGoingVC") as! OnGoingVC
            vc.offer = self.dashboard.offer
            vc.isInvestor = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tripleChoice(){
        let alert = UIAlertController(title: "Important", message: "Un prêt vous engage", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Accepter", style: .default, handler: { _ in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreationContractVC") as! CreationContractVC
            vc.isInvestor = false
            vc.offer = self.dashboard.offer
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        alert.addAction(UIAlertAction(title: "Refuser", style: .destructive, handler: { _ in
            let user:User = UserDefaults.getUser()!
            let bearer:String = "Bearer \(user.token)"
            let headers: HTTPHeaders = [ "Authorization": bearer, "Accept": "application/json"]
            guard let id = self.dashboard.offer?.id else { return }
            let params:Parameters = ["offer_id": id]
            
            headersRequest(params: params, endpoint: .refuseOffer , method: .post, header: headers, handler: {
                (success, json) in
                if (success){
                    print(json ?? "Aucune valeur dans le JSON")
                    self.showSingleAlertWithCompletion(title: "L'offre à bien été refusée", message: "", handler: {
                        _ in
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                } else {
                    self.showSingleAlert(title: "Une erreur est survenue", message: "Veuillez réessayer")
                }
            })
        }))
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel , handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dashboard.offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.bottomTableView.dequeueReusableCell(withIdentifier: "MoneyBackCell", for: indexPath) as! MoneyBackCell
        cell.containerView.setSpecificShadow()
        cell.containerView.roundBorder(radius: 5)

        if let project = self.dashboard.offers[indexPath.row].project {
            cell.titleLabel.text = project.title
            
            if project.state == "waiting" {
                cell.seeMoreButton.setTitle("En attente", for: .normal)
                cell.seeMoreButton.isEnabled = false
                cell.totalView.isHidden = true
                cell.totalAmountLabel.isHidden = true
                cell.progressView.isHidden = true
                cell.moneyBackLabel.isHidden = true
            } else if project.state == "refused" {
                cell.seeMoreButton.setTitle("Proposition refusée", for: .normal)
                cell.seeMoreButton.isEnabled = false
                cell.totalView.isHidden = true
                cell.totalAmountLabel.isHidden = true
                cell.progressView.isHidden = true
                cell.moneyBackLabel.isHidden = true
            } else if project.state == "running" {
                let finalPrice = Float(project.price) + (((Float(project.price) * 0.1) / 12) * Float(project.timeLaps))
                cell.totalAmountLabel.text = String(format: "sur %.2f€", finalPrice)
                let cgfinal = CGFloat(finalPrice)
                let maxPrice:CGFloat = cgfinal
                let minPrice:CGFloat = cgfinal / 1
                let percentagePrice:CGFloat = CGFloat(minPrice * 100) / CGFloat((maxPrice == 0) ? 1 : maxPrice)
                let width:CGFloat = cell.totalView.frame.width
                let newWidth:CGFloat = CGFloat(percentagePrice * width) / 100
                let newTrailing:CGFloat = CGFloat(width - newWidth)
                cell.moneyBackLabel.text = "0€"
                cell.progressViewTrailing.constant = newTrailing
                cell.totalView.isHidden = false
                cell.totalAmountLabel.isHidden = false
                cell.progressView.isHidden = false
                cell.moneyBackLabel.isHidden = false
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.bottomTableViewHeightConstraint.constant = CGFloat(150 * self.dashboard.offers.count)
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.bottomTableView.deselectRow(at: indexPath, animated: true)

        guard let tmpProject = self.dashboard.offers[indexPath.row].project else { return }
        if tmpProject.state == "waiting" {
            self.showSingleAlert(title: "En attente", message: "Nous sommes en attente du retour du demandeur.")
        } else if tmpProject.state == "running" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnGoingVC") as! OnGoingVC
            vc.offer = self.dashboard.offers[indexPath.row]
            vc.isInvestor = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.showSingleAlert(title: "Désolé...", message: "Le propriétaire de l'application n'à pas accepté votre offre")
        }
    }
}
