//
//  FileManager-DocumentsDirectory.swift
//  Flashzilla
//
//  Created by Justin Wells on 12/7/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
