//
//  OnGoingTVC.swift
//  Euko
//
//  Created by Victor Lucas on 07/04/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

class OnGoingTVC: UITableViewCell {

    @IBOutlet weak var validatedImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var underLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
