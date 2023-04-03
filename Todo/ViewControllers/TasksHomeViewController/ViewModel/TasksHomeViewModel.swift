//
//  TasksHomeViewModel.swift
//  Todo
//
//  Created by Pratham Gupta on 28/03/23.
//

import Foundation

class TasksHomeViewModel {
    
    func loadUserTasks() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = URL(fileURLWithPath: "user_task_file", relativeTo: directoryURL).appendingPathExtension("txt")
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            allData = try decoder.decode([String: [TaskList]].self, from: data)
            tasksList = allData[UserDefaults.standard.string(forKey: "loggedInUsername")!]!
            print(tasksList)
            DispatchQueue.global().async {
                mergreTaskLists()
            }
        } catch {
            print("Unable to retrieve users")
        }
    }
}
