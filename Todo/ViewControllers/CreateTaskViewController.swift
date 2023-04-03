//
//  CreateTaskViewController.swift
//  Todo
//
//  Created by Pratham Gupta on 10/03/23.
//

import UIKit

class CreateTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorities[row]
    }
    
    @IBOutlet weak var tfTaskName: UITextField!
    @IBOutlet weak var tvTaskDesc: UITextView!
    @IBOutlet weak var childCreateTaskView: UIView!
    @IBOutlet weak var btnSelectDate: UIButton!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var dpTaskDate: UIDatePicker!
    @IBOutlet weak var notification: UIButton!
    var notificationVal: Bool = true
    @IBOutlet weak var pvPriority: UIPickerView!
    
    weak var delegate: UpdateTodoListDelegate?
    
    
    var listIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        childCreateTaskView.layer.cornerRadius = 10
        tvTaskDesc.layer.borderWidth = 0.5
        tvTaskDesc.layer.borderColor = UIColor.systemGray6.cgColor
        dpTaskDate.backgroundColor = .systemGray6
        
        pvPriority.delegate = self
        pvPriority.dataSource = self
    }
    
    // MARK: - Click and Tap Gestures
    
    @IBAction func OnClickDateSelectBtn(_ sender: Any) {
        
        viewDate.isHidden = false
        dpTaskDate.isHidden = false
        pvPriority.isHidden = true
    }
    
    @IBAction func onClickNotification(_ sender: Any) {
        
        notificationVal = !notificationVal
        notification.setImage(notificationVal ? UIImage(systemName: "bell.fill") : UIImage(systemName: "bell.slash.fill"), for: .normal)
    }
    
    @IBAction func onClickPriority(_ sender: Any) {
        
        viewDate.isHidden = false
        dpTaskDate.isHidden = true
        pvPriority.isHidden = false
    }
    
    
    @IBAction func btnCreateNewTask(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"
        let strKey = dateFormatter.string(from: dpTaskDate.date)
        print(strKey)
        if(listIndex>=0)
        {
            if(tasksList[listIndex].list.keys.contains(strKey)) {
                tasksList[listIndex].list[strKey]!.append(Task(taskName: tfTaskName.text ?? "Task Unnamed", taskDesc: tvTaskDesc.text ?? "None", date: dpTaskDate.date, priority: priorities[pvPriority.selectedRow(inComponent: 0)], notification: notificationVal, completed: false))
                
                allTaskList.list[strKey]!.append(Task(taskName: tfTaskName.text ?? "Unnamed", taskDesc: tvTaskDesc.text ?? "None", date: dpTaskDate.date, priority: priorities[pvPriority.selectedRow(inComponent: 0)], notification: notificationVal, completed: false))
                
            }
            else
            {
                tasksList[listIndex].list[strKey] = [Task(taskName: tfTaskName.text ?? "Unnamed", taskDesc: tvTaskDesc.text ?? "None", date: dpTaskDate.date, priority: priorities[pvPriority.selectedRow(inComponent: 0)], notification: notificationVal, completed: false)]
                
                if(allTaskList.list.keys.contains(strKey))
                {
                    allTaskList.list[strKey]!.append(Task(taskName: tfTaskName.text ?? "Unnamed", taskDesc: tvTaskDesc.text ?? "None", date: dpTaskDate.date, priority: priorities[pvPriority.selectedRow(inComponent: 0)], notification: notificationVal, completed: false))
                }
                else
                {
                    allTaskList.list[strKey] = [Task(taskName: tfTaskName.text ?? "Unnamed", taskDesc: tvTaskDesc.text ?? "None", date: dpTaskDate.date, priority: priorities[pvPriority.selectedRow(inComponent: 0)], notification: notificationVal, completed: false)]
                }
            }
            tasksList[listIndex].itemCount += 1
            allTaskList.itemCount += 1
            
            if(delegate == nil) {
                print("Null")
            }
            else{
                print("NOt null")
            }
            
            delegate?.updateList()
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func onViewDateTapped(sender: UITapGestureRecognizer) {
        
        viewDate.isHidden = true
    }

}

// MARK: - Update Todo List Delegate Protocol

protocol UpdateTodoListDelegate: AnyObject {
    
    func updateList()
}
