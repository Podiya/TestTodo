//
//  TodoTableViewCell.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/16/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import UIKit

protocol TodoCellDelegate {
    func checkedTodo(index: IndexPath, task: Task)
}

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var priority: UIView!
    @IBOutlet weak var checkDot: UIView!
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    var delegate: TodoCellDelegate!
    var indexPath: IndexPath!
    var task: Task! {
        didSet {
            name.text = task.name
            dateTime.text = task.dateTime
            priority.backgroundColor = task.priority.color
            checkDot.backgroundColor = task.isCompleted ? .red : .clear
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        checkView.isUserInteractionEnabled = true
        checkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkedTodo)))
    }

    @objc func checkedTodo() {
        guard let index = indexPath  else { return }
        guard let task = task  else { return }
        guard !task.isCompleted else { return }
        checkDot.backgroundColor = .red
        delegate?.checkedTodo(index: index, task: task)
    }
}
