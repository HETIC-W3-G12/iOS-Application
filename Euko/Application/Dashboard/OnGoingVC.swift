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
    
    var isInvestor:Bool = false
    
    var received:Double = 0
    var total:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.offer?.delegate = self
        
        self.seeContractButton.roundBorder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        self.offer?.fillDeadlines()
        self.setTopLabel()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func seeContract(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContractDownloadVC") as! ContractDownloadVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setTopLabel(){
        self.total = 0
        self.received = 0
        
        for item in self.offer?.deadlines ?? [] {
            if item.state == .done {
                self.received += item.amout ?? 0
            }
            self.total += item.amout ?? 0
        }
        
        if (self.isInvestor == true){
            self.firstLabel.text = String(format: "Vous avez déjà reçu un total de %.2f€ sur %.2f€", self.received, self.total)
            self.secondLabel.text = String(format: "Dont %.2f€ d'intérêts", self.received * 0.1)
        } else {
            self.firstLabel.text = String(format: "Vous avez déjà envoyé un total de %.2f€ sur %.2f€", self.received, self.total)
            self.secondLabel.text = String(format: "Dont %.2f€ d'intérêts", self.received * 0.1)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offer?.deadlines.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "OnGoingTVC", for: indexPath) as! OnGoingTVC
        switch self.offer?.deadlines[indexPath.row].state {
        case .done?:
            cell.validatedImage.image = UIImage(named: "yes_icone")
            cell.underLabel.text = "Déjà reçu"
            break
        case .late?:
            cell.validatedImage.image = UIImage(named: "no_icone")
            cell.underLabel.text = "En retard"
            break
        case .waiting?:
            cell.validatedImage.image = UIImage(named: "no_icone")
            cell.underLabel.text = "Dans moins de \(indexPath.row + 1) mois"
            break
        default:
            break
        }
        cell.priceLabel.text = String(format: "%.2f", self.offer?.deadlines[indexPath.row].amout ?? 0)
        cell.titleLabel.text = "\(self.offer?.deadlines[indexPath.row].dueDate?.toString() ?? "Date error")"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension OnGoingVC: OfferDelegate {
    func reloadData() {
        self.setTopLabel()
        self.tableView.reloadData()
    }
    
    func couldNotGetDeadlines() {
        self.showSingleAlert(title: "Erreur lors du chargement des echéances",
                             message: "Si le problème persiste, veuillez nous contacter à l'adresse suivante : support@euko.com")
    }
}
