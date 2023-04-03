//
//  Settings.swift
//  Todo
//
//  Created by Pratham Gupta on 19/03/23.
//

import Foundation

struct Settings {
    
    let name: String
    let options: [String]
}

let settingsOption: [Settings] = [Settings(name: "Account", options: ["Profile", "Premium"]), Settings(name: "Preferences", options: ["Color", "Quick add bar", "First Day", "Default List", "Language", "Sound"]), Settings(name: "Any Do", options: ["Priority Support"])]
