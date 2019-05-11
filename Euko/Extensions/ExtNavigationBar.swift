//
//  ExtNavigationBar.swift
//  Euko
//
//  Created by Victor Lucas on 11/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
