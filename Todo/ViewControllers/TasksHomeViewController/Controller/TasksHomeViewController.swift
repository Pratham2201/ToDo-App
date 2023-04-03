//
//  TasksHomeViewController.swift
//  Todo
//
//  Created by Pratham Gupta on 10/03/23.
//

import UIKit

var addTask = TaskList(listName: "AddTask", list: [:], itemCount: 0, systemImgName: "plus")

class TasksHomeViewController: UIViewController {
    
    var viewModel = TasksHomeViewModel()
    
    @IBOutlet weak var taskCollection: UICollectionView!
    var selectedList: IndexPath?
    
    // MARK: - View Life-cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        taskCollection.delegate = self
        taskCollection.dataSource = self
        title = "My Lists"
        viewModel.loadUserTasks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View Appeared")
        if let itemIndex = selectedList {
            taskCollection.reloadItems(at: [itemIndex])
            taskCollection.reloadItems(at: [IndexPath(index: .zero)])
        }
    }
    
    // MARK: - Utility Functions
    func setupTaskCell(cell: TaskListCollectionViewCell, task: TaskList, textColor: UIColor, tintColor: UIColor) {
        cell.taskImage.image = UIImage(systemName: task.systemImgName)
        cell.lblTaskTitle.text = task.listName
        cell.lblTaskCount.text = "\(task.itemCount) Items"
        cell.taskImage.tintColor = tintColor
        cell.lblTaskTitle.textColor = textColor
    }
}

// MARK: - Colleaction View
extension TasksHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasksList.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskListCollectionViewCell", for: indexPath) as? TaskListCollectionViewCell else { return UICollectionViewCell() }
        
        if(indexPath.row == tasksList.count+1) {
            setupTaskCell(cell: cell, task: addTask, textColor: .black, tintColor: .systemGreen)
        }
        else if(indexPath.row == 0){
            setupTaskCell(cell: cell, task: allTaskList, textColor: .systemGreen, tintColor: .black)
        }
        else {
            setupTaskCell(cell: cell, task: tasksList[indexPath.row-1], textColor: .systemGreen, tintColor: .black)
        }
        
        cell.taskCard.layer.borderWidth = 1
        cell.taskCard.layer.borderColor = CGColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        cell.taskCard.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == tasksList.count+1){
            let viewController = getUIViewControllerFromID("CreateNewTaskListViewController") as? CreateNewTaskListViewController
            viewController?.delegate = self
            self.present(viewController!, animated: true, completion: nil)
            
        } else {
            let viewController = getUIViewControllerFromID("TodoTasksViewController") as? TodoTasksViewController
            selectedList = indexPath
            viewController?.listIndex = selectedList!.row
            navigationController?.pushViewController(viewController!, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width-20)/2, height: collectionView.frame.size.height/3)
    }
}

// MARK: - Update Collection View
extension TasksHomeViewController: UpdateCollectionViewTaskListDelegate {
    
    func updateTaskListView() {
        taskCollection.reloadData()
    }
}
