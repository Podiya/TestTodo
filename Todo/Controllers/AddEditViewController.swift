//
//  AddEditViewController.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/16/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import UIKit
import RealmSwift
import Toaster


class AddEditViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewBottom: NSLayoutConstraint!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet var priorities: [UIButton]!
    @IBOutlet weak var isCompleted: UISwitch!
    @IBOutlet weak var taskName: UITextField!
    fileprivate var selectedPriority: Priority = .none
    var taskType: TaskType = .add
    var task: Task!
    var taskIndex: Int!
    @IBOutlet weak var datePicker: UIDatePicker!
    let viewModel = AddEditViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        if let nav = self.navigationController,
            let item = nav.navigationBar.topItem {
            item.backBarButtonItem  = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action:
                #selector(self.didPressBack))
        }
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: NavBar.done, style: UIBarButtonItemStyle.done, target: self, action:
                            #selector(self.didPressDone)), animated: true)
        self.dateTime.text = Date().formated()
        self.isCompleted.isEnabled = taskType == .edit
        self.dateTime.isUserInteractionEnabled = true
        self.dateTime.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapedOnDateTime)))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removePicker)))
    }

    override func viewWillAppear(_ animated: Bool) {
        if let task = task {
            self.dateTime.text = task.dateTime
            self.taskName.text = task.name
            self.isCompleted.isOn = task.isCompleted
            selectPriority(priority: task.priority)
        }
    }

    @objc func didPressBack() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func didPressDone() {
        guard let date = dateTime.text!.date() else { return }
        if date < Date() {
            Toast(text: Alert.selectFutureDate, duration: Delay.short).show()
        }
        viewModel.task = Task(
            id: viewModel.id,
            name: taskName.text ?? "",
            isCompleted: isCompleted.isOn,
            priority: selectedPriority,
            dateTime: dateTime.text ?? "")
        
        if taskType == .add {
            viewModel.add()
        } else if taskType == .edit {
            viewModel.task.id = self.task.id
            viewModel.update(index: taskIndex)
        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func didChangeCompleted(_ sender: UISwitch) {
        guard let date = dateTime.text!.date() else { return }
        if task.isCompleted && date < Date() {
            sender.setOn(true, animated: true)
            Toast(text: Alert.selectFutureDate, duration: Delay.short).show()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didSelectPriority(_ sender: UIButton) {
        selectPriority(priority: Priority(rawValue: sender.tag)!)
    }

    func selectPriority(priority: Priority) {
        for p in priorities {
            if p.tag == priority.rawValue {
                p.backgroundColor = priority.color
                selectedPriority = priority
            } else { p.backgroundColor = .lightGray }
        }
    }

    @objc func tapedOnDateTime(gesture: UITapGestureRecognizer) {
        taskName.resignFirstResponder()
        datePicker.addTarget(self, action: #selector(pickedDate), for: .valueChanged)
        datePicker.isHidden = false
        scrollViewBottom.constant = -(datePicker.frame.height - 100)
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 50)
    }

    @objc func pickedDate(picker: UIDatePicker) {
        if picker.date > Date() {
            dateTime.text = picker.date.formated()
        }
    }

    @objc func removePicker() {
        datePicker.isHidden = true
        taskName.resignFirstResponder()
        scrollViewBottom.constant = 0.0
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollViewBottom.constant = -(keyboardSize.height - 100)
        }

    }

    @objc func keyboardWillHide(notification: Notification) {
        scrollViewBottom.constant = 0.0
    }
}
