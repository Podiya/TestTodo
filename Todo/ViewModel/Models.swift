//
//  Models.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/17/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import Foundation

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
