//
//  HomeTableViewController.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/16/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import UIKit




class HomeTableViewController: UITableViewController {

    var todoTasks: [Task] = []
    var isEditEnabled = false
    let viewModel = AddEditViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = UIView()
        self.tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData(tasks: tasks.value)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tasks.bind { (tasks) in
            self.loadData(tasks: tasks)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didPressEdit(_ sender: UIBarButtonItem) {
        isEditEnabled = !isEditEnabled
        if isEditEnabled {
            self.navigationItem.rightBarButtonItem?.title = NavBar.done
        } else {
            self.navigationItem.rightBarButtonItem?.title = NavBar.edit
        }
    }

    func loadData(tasks: [Task]) {
        self.todoTasks = tasks.filter({ (task) -> Bool in
            guard let date = task.dateTime.date() else { return false }
            return !task.isCompleted && date > Date()
        })
        self.todoTasks = self.todoTasks.sorted { $0.dateTime.date() < $1.dateTime.date() }
        self.viewModel.setDone(tasks: Array(Set<Task>(tasks).subtracting(self.todoTasks)))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.notDone, for: indexPath) as! TodoTableViewCell
        cell.task = todoTasks[indexPath.row]
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditEnabled {
            let controller = StoryBoard.get(type: AddEditViewController.self, controller: AddEdit.className)
            controller.task = todoTasks[indexPath.row]
            controller.taskType = .edit
            controller.taskIndex = viewModel.getIndex(task: todoTasks[indexPath.row])


            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == AddEdit.segue {
            let controller = (segue.destination as! AddEditViewController)
            controller.taskType = .add
        }
    }

}
    // MARK: - TodoCellDelegate
extension HomeTableViewController: TodoCellDelegate {
    func checkedTodo(index: IndexPath, task: Task) {
        let taskIndex = viewModel.getIndex(task: task)
        viewModel.task = task
        viewModel.task.isCompleted = true
        viewModel.update(index: taskIndex)
    }
}


