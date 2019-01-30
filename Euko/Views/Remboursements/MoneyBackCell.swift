//
//  MoneyBackCell.swift
//  Euko
//
//  Created by Victor Lucas on 21/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class MoneyBackCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyBackLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var totalView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
