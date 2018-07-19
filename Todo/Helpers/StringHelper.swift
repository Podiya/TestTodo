//
//  StringHelper.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/18/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import Foundation

struct ProfileKey {
    static var profileImage = "profile_image"
    static var fullName = "full_name"
    static var contactNumber = "contact_number"
    static var email = "email"
}

struct NavBar {
    static var done = "Done"
    static var edit = "Edit"
}

struct TodoCell {
    static var notDone = "notDoneCell"
    static var done = "doneCell"
}

struct AddEditController {
    static var className = "AddEditViewController"
    static var segue = "addTodo"
}

struct Alert {
    static var selectFutureDate = "Please select future date"
    static var successfulySaved = "Successfuly saved"
    static var enterCorrectEmail = "Enter Correct Email"
}
