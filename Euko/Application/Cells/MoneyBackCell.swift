//
//  MoneyBackCell.swift
//  Euko
//
//  Created by Victor Lucas on 21/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class MoneyBackCell: UITableViewCell {

    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyBackLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressViewTrailing: NSLayoutConstraint!
    
    var offer:Offer? {
        didSet (item) {
            guard let project = item?.project else { return }
            self.titleLabel.text = project.title
            
            if item?.state == .waiting {
                self.seeMoreButton.setTitle("En attente", for: .normal)
                self.seeMoreButton.isEnabled = false
            } else if item?.state == .refused {
                self.seeMoreButton.setTitle("Proposition refusée", for: .normal)
                self.seeMoreButton.isEnabled = false
            } else if item?.state == .accepted {
                let rand = Float.random(in: 1 ..< 12)
                self.moneyBackLabel.text = String(format: "%.2f€", ceil((project.finalPrice ?? 0) / rand))
                self.totalAmountLabel.text = String(format: "sur %.f€", ceil(project.finalPrice ?? 0))
                let maxPrice:CGFloat = CGFloat(project.finalPrice ?? 0)
                let minPrice:CGFloat = CGFloat((project.finalPrice ?? 0) / rand)
                let percentagePrice:CGFloat = CGFloat(minPrice * 100) / CGFloat((maxPrice == 0) ? 1 : maxPrice)
                let width:CGFloat = self.totalView.frame.width
                let newWidth:CGFloat = CGFloat(percentagePrice * width) / 100
                let newTrailing:CGFloat = CGFloat(width - newWidth)
                self.progressViewTrailing.constant = newTrailing
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
