//
//  CreateNewTaskListViewController.swift
//  Todo
//
//  Created by Pratham Gupta on 18/03/23.
//

import UIKit

class CreateNewTaskListViewController: UIViewController {

    @IBOutlet weak var tfTaskListName: UITextField!
    
    var delegate: UpdateCollectionViewTaskListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnOnClickCreateNewTaskList(_ sender: Any) {
        
        tasksList.append(TaskList(listName: tfTaskListName.text!, list: [:], itemCount: 0, systemImgName: "suitcase"))
        
        delegate?.updateTaskListView()
        self.dismiss(animated: true)
        
    }
    

}

protocol UpdateCollectionViewTaskListDelegate: AnyObject {
    
    func updateTaskListView()
}
