//
//  DataManager.swift
//  SnowSeeker
//
//  Created by Justin Wells on 12/14/22.
//

import Foundation

struct DataManager {
    static let savePath = FileManager.documentsDirectory.appendingPathComponent("SaveData")
    
    static func load() -> Set<String> {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                return decoded
            }
        }
        
        return []
    }
    
    static func save(_ resorts: Set<String>) {
        if let data = try? JSONEncoder().encode(resorts) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}
