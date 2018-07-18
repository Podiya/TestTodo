//
//  ProfileViewController.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/17/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import UIKit
import Toaster


class ProfileViewController: UIViewController {

    @IBOutlet weak var scrollViewBottom: NSLayoutConstraint!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    var imagePicker = UIImagePickerController()
    var viewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(remove)))
        self.profileImage.isUserInteractionEnabled = true
        self.profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnProfile)))
        viewModel.isExistProfileData { (image, fullName, contactNumber, email) in
            profileImage.image = image
            self.fullName.text = fullName
            self.contactNumber.text = contactNumber
            self.email.text = email
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didPressedSave(_ sender: UIBarButtonItem) {
        remove()
        viewModel.saveProfileData(
            fullName: fullName.text ?? "",
            contectNumber: contactNumber.text ?? "",
            email: email.text ?? "")
        guard let image = profileImage.image else {
            return
        }
        do {
            try viewModel.saveImage(image: image)
        } catch let error {
            Toast(text: error.localizedDescription, duration: Delay.short).show()
        }
    }

    @objc func didTapOnProfile(gesture: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollViewBottom.constant = -(keyboardSize.height - 40)
        }

    }

    @objc func keyboardWillHide(notification: Notification) {
        scrollViewBottom.constant = 0.0
    }

    @objc func remove() {
        fullName.resignFirstResponder()
        contactNumber.resignFirstResponder()
        email.resignFirstResponder()
    }
}

extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        profileImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
}


