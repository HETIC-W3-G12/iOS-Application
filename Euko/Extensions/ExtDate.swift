//
//  ExtDate.swift
//  Euko
//
//  Created by Victor Lucas on 16/05/2019.
//  Copyright © 2019 Victor Lucas. All rights reserved.
//

import Foundation

extension Date {
    func toString(format:String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
