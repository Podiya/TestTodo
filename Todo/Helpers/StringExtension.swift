//
//  StringExtension.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/17/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import Foundation

extension String {
    func date(format: String = "MMMM d yyyy - h:mm a") -> Date! {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
}
