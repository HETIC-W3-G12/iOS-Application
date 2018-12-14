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
    @IBOutlet weak var descriptionLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.insideView.layer.cornerRadius = 8
        
        self.shadowView.layer.cornerRadius = 8
        self.shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        self.shadowView.layer.shadowOpacity = 1
        self.shadowView.layer.shadowOffset = .zero
        self.shadowView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
