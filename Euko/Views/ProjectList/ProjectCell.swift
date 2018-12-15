//
//  ProjectCell.swift
//  Euko
//
//  Created by Victor Lucas on 14/12/2018.
//  Copyright © 2018 Victor Lucas. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.insideView.layer.cornerRadius = 8
        
        self.shadowView.layer.cornerRadius = 10
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOpacity = 0.7
        self.shadowView.layer.shadowOffset = CGSize(width: -2, height: 2)
        self.shadowView.layer.shadowRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
