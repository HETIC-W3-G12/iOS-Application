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
    @IBOutlet weak var triangleLabel: UILabel!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.triangleLabel.transform = CGAffineTransform(rotationAngle: .pi/4)
        self.insideView.layer.cornerRadius = 0
        self.shadowView.layer.cornerRadius = 0
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOpacity = 0.2
        self.shadowView.layer.shadowOffset = CGSize(width: -5, height: 5)
        self.shadowView.layer.shadowRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        //TODO: Configure the view for the selected state
    }
}
