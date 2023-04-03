//
//  CalendarViewController.swift
//  Todo
//
//  Created by Pratham Gupta on 08/03/23.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var collectionViewCalendar: UICollectionView!
    @IBOutlet weak var tableCalendar: UITableView!
    
    var prevCell: CalendarCollectionViewCell!
    
    var keyList: [String] = []
    
    var calendar = Calendar.current
    var date = Date()
    var dateFormatter = DateFormatter()
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableCalendar.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoTableViewCell")
        
        dateFormatter.dateFormat = "MMMM, y"
        title = dateFormatter.string(from: Date())
        
        tableCalendar.delegate = self
        tableCalendar.dataSource = self
        
        collectionViewCalendar.delegate = self
        collectionViewCalendar.dataSource = self
        
        print("calendar ViewDidAppaear")
        
        keyList = Array(allTaskList.list.keys).sorted()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("calendar ViewDidAppaear")
        keyList = Array(allTaskList.list.keys).sorted()
        tableCalendar.reloadData()
    }
    
    // MARK: - Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allTaskList.list[keyList[section]]!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as? TodoTableViewCell else { return TodoTableViewCell() }
        
        let taskItem = allTaskList.list[keyList[indexPath.section]]![indexPath.row]
        
        cell.lblTask.text = taskItem.taskName
        
        setUpCellData(taskItem: taskItem, cell: cell, indexPath: indexPath)
        setTimeColor(cell: cell, num: indexPath.row%3)
        setUpTaskItem(check: taskItem.completed, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? TodoTableViewCell else { return }
        let check = cell.completed
        
        setUpTaskItem(check: !check, cell: cell)
        
        cell.completed = !check
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = setUpHeaderView(tableView: tableView)
        let label = setUpHeaderLabel(headerView: headerView, section: section)
        
        headerView.addSubview(label)
        
        label.sizeToFit()
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    // MARK: - Utility Functions
    
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
    
    func setUpTaskItem(check: Bool, cell: TodoTableViewCell) {
        
        cell.btnCheck.setImage(UIImage(named: (check) ? "checked" :  "unchecked") as UIImage?, for: .normal)
        cell.lblTask.textColor = (check) ? .systemGray : .black
        cell.btnCross.isHidden = !check
        cell.lblTime.isHidden = check
    }
    
    func setUpHeaderView(tableView: UITableView) -> UIView {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 35))
        headerView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        
        return headerView
    }
    
    func setUpHeaderLabel(headerView: UIView, section: Int) -> UILabel {
        
        let label = UILabel()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd"
        
        label.text = dateFormatter.string(from: allTaskList.list[keyList[section]]![0].date)
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

// MARK: - Collection View Methods

extension CalendarViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarViewCell", for: indexPath) as? CalendarCollectionViewCell else { return CalendarCollectionViewCell() }
        
        cell.lblDate.text = "\(calendar.component(.day, from: date) + indexPath.row)"
        
        dateFormatter.dateFormat = "E"
        cell.lblDay.text = dateFormatter.string(from: Date(timeIntervalSinceNow: TimeInterval(86400*indexPath.row)))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let prev = prevCell {
            
            setUpCellColor(cell: prev, textColor: .black, tintColot: .systemGray6)
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell else { return }
        
        prevCell = cell
        
        setUpCellColor(cell: cell, textColor: .systemGreen, tintColot: .systemGreen)
    }
    
    func setUpCellColor(cell: CalendarCollectionViewCell, textColor: UIColor, tintColot: UIColor) {
        
        cell.lblDate.textColor = textColor
        cell.lblDay.textColor = textColor
        cell.circleFocus.tintColor = tintColot
    }
}
