//
//  CompletedTableViewController.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/16/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import UIKit

class CompletedTableViewController: UITableViewController {

    private var todoTasks: [Task] = []
    private var isEditEnabled = false
    private var viewModel = AddEditViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = UIView()
        self.tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData(tasks: tasks.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tasks.bind { [unowned self]  in
            self.loadData(tasks: $0)
        }
    }
    
    @IBAction func didPressEdit(_ sender: UIBarButtonItem) {
        isEditEnabled = !isEditEnabled
        if isEditEnabled {
            self.navigationItem.rightBarButtonItem?.title = NavBar.done
        } else {
            self.navigationItem.rightBarButtonItem?.title = NavBar.edit
        }
    }

    private func loadData(tasks: [Task]) {
        self.todoTasks = tasks.filter({ (task) -> Bool in
            return task.isCompleted
        })
        self.todoTasks = self.todoTasks.sorted { $0.dateTime.date() > $1.dateTime.date() }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTasks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.done, for: indexPath) as! TodoTableViewCell
        cell.task = todoTasks[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditEnabled {
            let controller = StoryBoard.get(type: AddEditViewController.self, controller: AddEditController.className)
            controller.task = todoTasks[indexPath.row]
            controller.taskType = .edit
            controller.taskIndex = viewModel.getIndex(task: todoTasks[indexPath.row])
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
