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
    
    func get(completion: (_ profile: Profile) -> Void) {
        completion(Profile(
            image: AppData.imageForKey(key: ProfileKey.profileImage),
            name: AppData.object(forKey: ProfileKey.fullName) as? String ?? "",
            contactNumber: AppData.object(forKey: ProfileKey.contactNumber)  as? String ?? "",
            email: AppData.object(forKey: ProfileKey.email) as? String ?? ""))
    }

    func save(profile: Profile, done: () -> Void) {
        AppData.setImage(image: profile.image, forKey: ProfileKey.profileImage)
        AppData.set(profile.name, forKey: ProfileKey.fullName)
        AppData.set(profile.contactNumber, forKey: ProfileKey.contactNumber)
        AppData.set(profile.email, forKey: ProfileKey.email)
        done()
    }

    func validate(email string: String?) -> Bool {
        guard let string = string else { return false }
        if string != "" {
            return (string.isEmail)
        }
        return true
    }
}
