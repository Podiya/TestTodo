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
        completion(AppData.imageForKey(key: Profile.profileImage),
                   AppData.object(forKey: Profile.fullName) as? String ?? "",
                   AppData.object(forKey: Profile.contactNumber)  as? String ?? "",
                   AppData.object(forKey: Profile.email) as? String ?? "")
    }

    func saveProfileData(image: UIImage?, fullName: String, contectNumber: String, email: String) {
        AppData.setImage(image: image, forKey: Profile.profileImage)
        AppData.set(fullName, forKey: Profile.fullName)
        AppData.set(contectNumber, forKey: Profile.contactNumber)
        AppData.set(email, forKey: Profile.email)
    }
}
