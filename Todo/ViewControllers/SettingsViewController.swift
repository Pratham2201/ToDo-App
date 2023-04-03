//
//  SettingsViewController.swift
//  Todo
//
//  Created by Pratham Gupta on 08/03/23.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableSettings: UITableView!
    @IBOutlet weak var optionSettings: UIBarButtonItem!
    
    // MARK: - Table View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableSettings.delegate = self
        tableSettings.dataSource = self
        
        title = "Settings"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsOption[section].options.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingViewCell", for: indexPath) as? SettingViewCell else { return SettingViewCell() }
        cell.lblSetting.text = settingsOption[indexPath.section].options[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = setUpHeaderView(tableView: tableView)
        let label = setUpHeaderLabel(headerView: headerView, section: section)
        
        headerView.addSubview(label)
        
        label.sizeToFit()
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    // MARK: - Click Functions
    
    @IBAction func onClickOptionButton(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.set(nil, forKey: "loggedInUsername")
        (UIApplication.shared.delegate as? AppDelegate)?.saveAllTasksFile()
        allTaskList = TaskList(listName: "All Tasks", list: [:], itemCount: 0, systemImgName: "suitcase")
        (UIApplication.shared.delegate as? AppDelegate)?.setUpRootVC()
    }
    
    // MARK: - Utility Functions
    
    func setUpHeaderView(tableView: UITableView) -> UIView {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        
        return headerView
    }
    
    func setUpHeaderLabel(headerView: UIView, section: Int) -> UILabel {
        
        let label = UILabel()
        
        label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = settingsOption[section].name
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 66/255, green: 214/255, blue: 71/255, alpha: 1)
        label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        
        return label
    }
}


