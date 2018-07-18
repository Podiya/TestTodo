//
//  RealmClasses.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/17/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class TaskDAO: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var isComplete = false
    @objc dynamic var dateTime = ""
    @objc dynamic var priority = -1

    convenience init(id: Int, name: String, isComplete: Bool, dateTime: String, priority: Int) {
        self.init()
        self.id = id
        self.name = name
        self.isComplete = isComplete
        self.dateTime = dateTime
        self.priority = priority
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}
