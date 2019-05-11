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
    
    var project:Project? {
        didSet (item) {
            let rand = Float.random(in: 1 ..< 12)
            self.titleLabel.text = item?.title
            self.moneyBackLabel.text = String(format: "%.2f€", ceil((item?.finalPrice ?? 0) / rand))
            self.totalAmountLabel.text = String(format: "sur %.f€", ceil(item?.finalPrice ?? 0))
            
            let maxPrice:CGFloat = CGFloat(item?.finalPrice ?? 0)
            let minPrice:CGFloat = CGFloat((item?.finalPrice ?? 0) / rand)
            let percentagePrice:CGFloat = CGFloat(minPrice * 100) / CGFloat((maxPrice == 0) ? 1 : maxPrice)
            
            let width:CGFloat = self.totalView.frame.width
            let newWidth:CGFloat = CGFloat(percentagePrice * width) / 100
            let newTrailing:CGFloat = CGFloat(width - newWidth)
            
            self.progressViewTrailing.constant = newTrailing
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
