//
//  Enums.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/17/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import UIKit


enum Priority: Int {
    case p0 = 0
    case p1 = 1
    case p2 = 2
    case p3 = 3
    case none = -1

    var color: UIColor {
        switch self {
        case .p0:
            return .clear
        case .p1:
            return .red
        case .p2:
            return .orange
        case .p3:
            return .green
        case .none:
            return .lightGray
        }
    }
}

enum StoryBoard {
    static func get<T>(type: T.Type, controller: String, storyBoard: String = "Main") -> T {
        let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: controller) as! T

    }
}


enum TaskType {
    case add
    case edit
}

enum AppData {

    static func set(_ object: Any, forKey defaultName: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(object, forKey:defaultName)
        defaults.synchronize()
    }

    static func object(forKey key: String) -> AnyObject! {
        let defaults: UserDefaults = UserDefaults.standard
        return defaults.object(forKey: key) as AnyObject?
    }

    static func exists(path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }

    static func imageForKey(key: String) -> UIImage? {
        var image: UIImage?
        if let imageData = UserDefaults.standard.data(forKey: key) {
            image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage
        }
        return image
    }
    static func setImage(image: UIImage?, forKey key: String) {
        var imageData: NSData?
        if let image = image {
            imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
        }
        AppData.set(imageData!, forKey: key)
    }
}

enum ImageSaveError: Error {
    case removeError(error: String)
    case writeError(error: String)
    case createDirectoryError(error: String)
}
