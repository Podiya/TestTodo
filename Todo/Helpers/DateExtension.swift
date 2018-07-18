//
//  DateExtension.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/16/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import Foundation

extension Date {
    func formated(format: String = "MMMM d yyyy - h:mm a") -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = format
        return dateFormatterGet.string(from: self)
    }
}
