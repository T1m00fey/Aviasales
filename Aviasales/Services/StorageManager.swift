//
//  StorageManager.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 22.06.2024.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    
    func save(from: String) {
        userDefaults.setValue(from, forKey: "from")
    }
    
    func getFrom() -> String {
        userDefaults.string(forKey: "from") ?? ""
    }
}
