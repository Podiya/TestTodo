//
//  ProfileViewModel.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/17/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel {
    
    func isExistProfileData(completion: (_ image: UIImage?, _ fullName: String, _ contactNumber: String, _ email: String) -> Void) {
        var image: UIImage!
        let fileURL = getFileURL()
        if AppData.exists(path: fileURL.path) {
            image = UIImage(contentsOfFile: fileURL.path)
        }
        completion(image,
                   AppData.object(forKey: "full_name") as? String ?? "",
                   AppData.object(forKey: "contact_number")  as? String ?? "",
                   AppData.object(forKey: "email") as? String ?? "")
    }

    func saveProfileData(fullName: String, contectNumber: String, email: String) {
        AppData.set(fullName, forKey: "full_name")
        AppData.set(contectNumber, forKey: "contact_number")
        AppData.set(email, forKey: "email")
    }

    func saveImage(image: UIImage) throws {
        let fileURL = getFileURL()
        do {
            if AppData.exists(path: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch let error {
            throw ImageSaveError.removeError(error: error.localizedDescription)
        }
        do {
            if let data = UIImageJPEGRepresentation(image, 1.0) {
                try data.write(to: fileURL)
            }
        } catch let error {
            throw ImageSaveError.writeError(error: error.localizedDescription)
        }
    }
}
