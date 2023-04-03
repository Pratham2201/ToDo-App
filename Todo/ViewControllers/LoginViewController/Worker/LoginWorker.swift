//
//  LoginWorker.swift
//  Todo
//
//  Created by Pratham Gupta on 27/03/23.
//

import Foundation

protocol DataLoader {
    
    func loadAllUsers() -> [User]?
}

class LoginWorker: DataLoader {
    
    func loadAllUsers() -> [User]? {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: "user_file", relativeTo: directoryURL).appendingPathExtension("txt")
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            return try decoder.decode([User].self, from: data)
        } catch {
            print("Unable to retrieve users")
        }
        return nil
    }
    
}
