//
//  ProfileVC.swift
//  Euko
//
//  Created by Victor Lucas on 14/03/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Default
    @IBOutlet weak var viewSelector: UISegmentedControl!
    @IBOutlet weak var polygonTitleLabel: UILabel!
    // Profile
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var downloadDataButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var birthDateTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var postCodeTF: UITextField!
    
    // View History
    @IBOutlet weak var historyScrollView: UIScrollView!
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

    // Variables
    let myLoan:Project = Project(id: "ok", title: "Vélo", description: "J'ai besoin d'un vélo pour aller au travail tous les jours sans avoir a prendre les transports en commun ni m'acheter une voiture.", state: "ok", price: 350, timeLaps: 12, interests: 0.1, finalPrice: 385, date: Date(timeIntervalSince1970: 16))
    
    let myFinancements:[Project] = [Project(id: "ok", title: "Balenciaga", description: "J'en ai vraiment trop besoin !", state: "ok", price: 300, timeLaps: 12, interests: 0.1, finalPrice: 330, date: Date(timeIntervalSince1970: 13)),
                                    Project(id: "ok", title: "Projet de test 2", description: "Description de test 2", state: "ok", price: 100, timeLaps: 12, interests: 0.1, finalPrice: 110, date: Date(timeIntervalSince1970: 15)),
                                    Project(id: "ok", title: "Projet de test 3", description: "Description de test 2", state: "ok", price: 100, timeLaps: 12, interests: 0.1, finalPrice: 760, date: Date(timeIntervalSince1970: 15)),
                                    Project(id: "ok", title: "Projet de test 4", description: "Description de test 2", state: "ok", price: 100, timeLaps: 12, interests: 0.1, finalPrice: 480, date: Date(timeIntervalSince1970: 15)),
                                    Project(id: "ok", title: "Projet de test 5", description: "Description de test 2", state: "ok", price: 100, timeLaps: 12, interests: 0.1, finalPrice: 200, date: Date(timeIntervalSince1970: 15)),
                                    Project(id: "ok", title: "Projet de test 6", description: "Description de test 3", state: "ok", price: 100, timeLaps: 12, interests: 0.1, finalPrice: 510, date: Date(timeIntervalSince1970: 15))]
   
    // Mark:- Default
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
        self.view.addDismisKeyBoardOnTouch()
        
        if (self.viewSelector.selectedSegmentIndex == 0){
            self.setupProfile()
            self.historyScrollView.isHidden = true
            self.profileView.isHidden = false
        } else {
            self.setupHistory()
            self.historyScrollView.isHidden = false
            self.profileView.isHidden = true
        }
        self.bottomTableView.delegate = self
        self.bottomTableView.dataSource = self
        
        self.profileView.addDismisKeyBoardOnTouch()
        self.saveButton.roundBorder()
        self.shadowView.roundBorder()
        self.shadowView.setSpecificShadow()
    }
    
    func setupProfile() {
        self.polygonTitleLabel.text = "Profil"
        
        let user = UserDefaults.getUser()
        self.emailTF.text = user?.email
        self.nameLabel.text = "\(user?.lastName ?? "") \(user?.firstName ?? "")"
        self.cityTF.text = user?.city
        self.addressTF.text = user?.address
        self.postCodeTF.text = user?.postCode.toString()
        self.birthDateTF.text = user?.birthDate.toString()
    }
    
    func setupHistory() {
        self.polygonTitleLabel.text = "Votre emprunt en cours"
        self.bottomTableView.reloadData()
        self.topViewContainer.setSpecificShadow()
        self.topViewContainer.roundBorder(radius: 5)
        self.setupTopCell()
    }
    
    //Mark:- History
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectVC") as! ProjectVC
        vc.project = self.myLoan
        vc.isLoan = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func switchView(_ sender: Any) {
        if (self.viewSelector.selectedSegmentIndex == 0){
            self.setupProfile()
            self.historyScrollView.isHidden = true
            self.profileView.isHidden = false
        } else if (self.viewSelector.selectedSegmentIndex == 1){
            self.setupHistory()
            self.historyScrollView.isHidden = false
            self.profileView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myFinancements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.bottomTableView.dequeueReusableCell(withIdentifier: "MoneyBackCell", for: indexPath) as! MoneyBackCell        
        cell.containerView.setSpecificShadow()
        cell.containerView.roundBorder(radius: 5)
        //cell.offer = self.myFinancements[indexPath.row]
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
    
    //Mark:- Profile
    @IBAction func saveAction(_ sender: Any) {
        
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        //TODO: Temporary deconnexion
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConnexionVC") as! ConnexionVC
        UserDefaults.deleteUser()
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = vc
    }
    
    @IBAction func downloadDataAction(_ sender: Any) {
        
    }
}
