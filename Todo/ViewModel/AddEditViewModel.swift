//
//  AddEditViewModel.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/17/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import Foundation

class AddEditViewModel {

    private(set) var task: Task!
    var id: Int {
        return DBManager.shared.incrementID(classType: TaskDAO.self)
    }
}

extension AddEditViewModel {

    func setTask(task: Task) {
        self.task = task
    }

    func add() {
        guard let task = task else { return }
        tasks.value.append(task)
        save()
    }

    func update(index: Int) {
        guard let task = task else { return }
        tasks.value.remove(at: index)
        tasks.value.insert(task, at: index)
        save(isUpdate: true)
    }

    private func save(isUpdate: Bool = false) {
        let db = DBManager.shared
        let id = isUpdate ? task.id : db.incrementID(classType: TaskDAO.self)
        db.save(obj: TaskDAO(id: id,
                             name: task.name,
                             isComplete: task.isCompleted,
                             dateTime: task.dateTime,
                             priority: task.priority.rawValue))
    }

    func setDone(tasks: [Task]) {
        var ids = [Int]()
        for task in tasks {
            ids.append(task.id)
        }
        DBManager.shared.setDone(ids: ids)
    }

    func getIndex(task: Task) -> Int {
        return tasks.value.index(of: tasks.value.first(where: { (t) -> Bool in
            return task == t
        })!)!
    }
}

