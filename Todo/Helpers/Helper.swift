//
//  Helper.swift
//  Todo
//
//  Created by Ravindu Senevirathna on 7/17/18.
//  Copyright © 2018 Ravindu Senevirathna. All rights reserved.
//

import Foundation


func getFileURL(for file: String = "profile.jpg") -> URL? {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent(file)
}

func directoryExsits(url: URL) throws {
    var directory: ObjCBool = ObjCBool(false)
    let _ = FileManager.default.fileExists(atPath: url.path, isDirectory: &directory)
    if !directory.boolValue {
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            throw ImageSaveError.createDirectoryError(error: error.description)
        }
    }
}
