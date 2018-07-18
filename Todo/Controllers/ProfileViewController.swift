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

    @IBOutlet weak var scrollView: UIScrollView!
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
        self.scrollView.isScrollEnabled = false
        self.contactNumber.delegate = self
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
        guard validate() else {
            Toast(text: Alert.enterCorrectEmail, duration: Delay.short).show()
            return
        }
        viewModel.saveProfileData(
            image: profileImage.image,
            fullName: fullName.text ?? "",
            contectNumber: contactNumber.text ?? "",
            email: email.text ?? "")
        Toast(text: Alert.successfulySaved, duration: Delay.short).show()
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
            self.scrollView.isScrollEnabled = true
            scrollViewBottom.constant = -(keyboardSize.height - 40)
        }

    }

    @objc func keyboardWillHide(notification: Notification) {
        self.scrollView.isScrollEnabled = false
        scrollViewBottom.constant = 0.0
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
    }

    @objc func remove() {
        fullName.resignFirstResponder()
        contactNumber.resignFirstResponder()
        email.resignFirstResponder()
    }

    func validate() -> Bool {
        if let text = email.text, text != "" {
            return (email.text?.isEmail)!
        }
        return true
    }
}

extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        profileImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if textField == contactNumber && newString.containsAlphabets {
            return false
        }
        return true
    }
}


