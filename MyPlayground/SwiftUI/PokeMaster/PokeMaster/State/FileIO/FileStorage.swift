//
//  FileStorage.swift
//  PokeMaster
//
//  Created by user on 2024/2/29.
//

import Foundation

@propertyWrapper
struct FileStorage<T: Codable> {
    var value: T?
    
    let directory: FileManager.SearchPathDirectory
    let fileName: String
    
    init(directory: FileManager.SearchPathDirectory, fileName: String) {
        value = try? FileHelper.loadJSON(from: directory, fileName: fileName)
        self.directory = directory
        self.fileName = fileName
    }
    
    var wrappedValue: T? {
        set {
            value = newValue
            if let value = newValue {
                try? FileHelper.writeJSON(value, to: .documentDirectory, fileName: "user.json")
            }
            else {
                try? FileHelper.delete(from: .documentDirectory, fileName: "user.json")
            }
        }
        get {
            value
        }
    }
}
