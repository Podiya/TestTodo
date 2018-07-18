//
//  DBManager.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/17/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import Foundation
import RealmSwift

var tasks: Box<[Task]> = Box([])

class DBManager {
    private init() {}
    static let shared = DBManager()
    private var fetchTimer: Timer!

    deinit {
        fetchTimer.invalidate()
    }

    func config() {
        fetch()
        fetchTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fetch), userInfo: nil, repeats: true)
    }

    func save<T: Object>(obj: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(obj, update: true)
        }
    }

    func clean() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }

    func incrementID<T: Object>(classType: T.Type) -> Int {
        let realm = try! Realm()
        return (realm.objects(classType).max(ofProperty: "id") ?? 0) + 1
    }

    func setDone(ids: [Int]) {
        let realm = try! Realm()
        for id in ids {
            let dao = realm.object(ofType: TaskDAO.self, forPrimaryKey: id)
            try! realm.write {
                dao?.isComplete = true
            }
        }
    }

    @objc private func fetch() {
        let realm = try! Realm()
        var taskArray = [Task]()
        for task in realm.objects(TaskDAO.self) {
            taskArray.append(Task(
                id: task.id,
                name: task.name,
                isCompleted: task.isComplete,
                priority: Priority(rawValue: task.priority)!,
                dateTime: task.dateTime))
        }
        tasks.value = taskArray
    }
}
