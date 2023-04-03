//
//  TodoTasksViewController.swift
//  Todo
//
//  Created by Pratham Gupta on 05/03/23.
//

import UIKit

class TodoTasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var btnCreateNewTask: UIButton!
    
    var listIndex: Int = 0
    var list: [String: [Task]] = [:]
    var keyList: [String] = []
    
    // MARK: -  View Life Cycle methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("viewDidLoad")
        
        if(listIndex == 0)
        {
            list = allTaskList.list
        }
        else
        {
            list = tasksList[listIndex-1].list
        }
        keyList = Array(list.keys)
        keyList = keyList.sorted()
        print(list)
        
        title = "Tasks"
        
        tasksTableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoTableViewCell")
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        if(list.count>0)
        {
            btnCreateNewTask.isHidden = true
        }
        
    }
    
    // MARK:  Tabke View Methods

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as? TodoTableViewCell else { return TodoTableViewCell() }
        
        let taskItem = list[keyList[indexPath.section]]![indexPath.row]
        
        setUpCellData(taskItem: taskItem, cell: cell, indexPath: indexPath)
        setTimeColor(cell: cell, num: indexPath.row%3)
        setUpTaskItem(check: taskItem.completed, cell: cell)
        cell.callBack = { indexValue in
            print(indexValue)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? TodoTableViewCell else { return }
        
        let taskItem = list[keyList[indexPath.section]]![indexPath.row]
        
        setUpTaskItem(check: !taskItem.completed, cell: cell)
        updateCompletedStatus(completed: !taskItem.completed, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = setUpHeaderView(tableView: tableView)
        let button = setUpCreateTaskButton(headerView: headerView)
        let label = setUpHeaderLabel(headerView: headerView, section: section)
        
        headerView.addSubview(label)
        headerView.addSubview(button)
        
        label.sizeToFit()
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[keyList[section]]!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    // MARK: - Click Actions
    
    @IBAction func onClickCreteNewTask(_ sender: Any) {
        
        presentCreateTaskController()
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        
        presentCreateTaskController()
    }
    
    // MARK: - Utility Functions
    
    func updateCompletedStatus(completed: Bool, indexPath: IndexPath){
        
        if(listIndex>0)
        {
            tasksList[listIndex-1].list[keyList[indexPath.section]]![indexPath.row].completed = completed
        }
        else
        {
            allTaskList.list[keyList[indexPath.section]]![indexPath.row].completed = completed
        }
        list[keyList[indexPath.section]]![indexPath.row].completed = completed
    }
    
    func setUpTaskItem(check: Bool, cell: TodoTableViewCell) {
        
        cell.btnCheck.setImage(UIImage(named: (check) ? "checked" :  "unchecked") as UIImage?, for: .normal)
        cell.lblTask.textColor = (check) ? .systemGray : .black
        cell.btnCross.isHidden = !check
        cell.lblTime.isHidden = check
    }
    
    func presentCreateTaskController() {
        
        guard let vc = getUIViewControllerFromID("PurpleViewController") as? CreateTaskViewController else { return }
        
        vc.listIndex = listIndex-1
        vc.delegate = self
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func setUpCellData(taskItem: Task, cell: TodoTableViewCell, indexPath: IndexPath) {
        
        cell.lblTask.text = taskItem.taskName
        cell.lblStatus.text = taskItem.taskDesc
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        cell.lblTime.text = dateFormatter.string(from: taskItem.date)
    }
    
    func setTimeColor(cell: TodoTableViewCell, num: Int)
    {
        switch(num)
        {
        case 0: do {
            setTimeLabelColor(cell.lblTime, color: cell.colorRed)
        }
        case 1: do {
            setTimeLabelColor(cell.lblTime, color: cell.colorGreen)
        }
        default: do {
            setTimeLabelColor(cell.lblTime, color: cell.colorYellow)
        }
        }
    }
    
    func setUpHeaderView(tableView: UITableView) -> UIView {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 35))
        headerView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        
        return headerView
    }
    
    func setUpCreateTaskButton(headerView: UIView) -> UIButton {
        
        let button = UIButton()
        
        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "add_task"), for: .normal)
        button.frame = CGRect(x: headerView.frame.width-40, y: headerView.frame.height-25, width: 23, height: 23)
        
        return button
    }
    
    func setUpHeaderLabel(headerView: UIView, section: Int) -> UILabel {
        
        let label = UILabel()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd"
        
        label.text = dateFormatter.string(from: list[keyList[section]]![0].date)
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 66/255, green: 214/255, blue: 71/255, alpha: 1)
        label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        
        return label
    }
    
    func setTimeLabelColor(_ label: UILabel, color: CGColor) {
        
        label.layer.borderColor = color
        label.textColor = UIColor(cgColor: color)
    }
    
}

// MARK: - Update Todo List Delegate Implementation

extension TodoTasksViewController : TodoTableViewCellDelegate, UpdateTodoListDelegate {
    
    func crossBtnTapped(index: IndexPath) {
        
        print("Btn tapped")
        let cell = tasksTableView.cellForRow(at: index) as? TodoTableViewCell
        cell?.taskCard.backgroundColor = .red
    }
    
    func updateList() {
        print("Update List")
        if(listIndex == 0)
        {
            list = allTaskList.list
        }
        else
        {
            list = tasksList[listIndex-1].list
        }
        
        if(list.count>0)
        {
            btnCreateNewTask.isHidden = true
        }
        
        keyList = Array(list.keys).sorted()
        
        DispatchQueue.main.async {
            self.tasksTableView.reloadData()
        }
    }
}
