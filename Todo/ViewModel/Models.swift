//
//  Models.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/17/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Task Model
class Task: Hashable {
    var id = 0
    var name = ""
    var isCompleted = false
    var priority: Priority = .none
    var dateTime = ""
    var hashValue: Int {
        return id.hashValue
    }

    init(id: Int, name: String, isCompleted: Bool, priority: Priority, dateTime: String) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
        self.priority = priority
        self.dateTime = dateTime
    }

    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}
// MARK: - Profile Model
class Profile {
    var image: UIImage!
    var name = ""
    var contactNumber = ""
    var email = ""

    init(image: UIImage, name: String, contactNumber: String, email: String) {
        self.image = image
        self.name = name
        self.contactNumber = contactNumber
        self.email = email
    }
}
