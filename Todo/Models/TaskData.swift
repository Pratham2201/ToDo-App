//
//  Tasks.swift
//  Todo
//
//  Created by Pratham Gupta on 13/03/23.
//

import Foundation
import UIKit

struct Task: Codable {
    let taskName: String
    let taskDesc: String
    let date: Date
    let priority: String
    let notification: Bool
    var completed: Bool
}

struct TaskList: Codable {
    let listName: String
    var list: [String: [Task]]
    var itemCount: Int
    let systemImgName: String
}

var tasksList: [TaskList] = []

let priorities = ["MAX Priority", "Normal", "MIN Priority"]

var allData: [String: [TaskList]] = [:]

var allTaskList: TaskList = TaskList(listName: "All Tasks", list: [:], itemCount: 0, systemImgName: "suitcase")

func mergreTaskLists(){
    
    for lists in tasksList{
        
        for item in lists.list {
            
            allTaskList.itemCount += item.value.count
            if allTaskList.list[item.key] == nil{
                allTaskList.list[item.key] = item.value
            }else
            {
                allTaskList.list[item.key]!.append(contentsOf: item.value)
            }
        }
    }
    print("Merged Task List")
    print(allTaskList.list)
}
