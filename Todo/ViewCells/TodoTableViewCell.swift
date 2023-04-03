//
//  TodoTableViewCell.swift
//  Todo
//
//  Created by Pratham Gupta on 06/03/23.
//

import UIKit

protocol TodoTableViewCellDelegate : AnyObject {
    
    func crossBtnTapped(index : IndexPath)
}

class TodoTableViewCell: UITableViewCell {
    
    weak var delegate : TodoTableViewCellDelegate?
    var callBack : ((IndexPath)->())?
    

    @IBOutlet weak var lblTask: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var taskCard: UIView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnCross: UIButton!
    
    //COLORS
    let colorRed = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
    let colorGreen = CGColor(red: 0, green: 0.8, blue: 0, alpha: 1)
    let colorYellow = CGColor(red: 250/255, green: 209/255, blue: 44/255, alpha: 1)
    
    var completed = false
    var index : IndexPath = IndexPath(row: 0, section: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnCross.addTarget(self, action: #selector(TodoTableViewCell.btnCrossTapped), for: .touchUpInside)
        
        taskCard.layer.borderWidth = 0.1
        taskCard.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        taskCard.layer.cornerRadius = 3
        
        lblTime.layer.cornerRadius = 12
        lblTime.layer.borderWidth = 0.4
        
        lblStatus.text = "Status Good"
        lblTime.text = "10:00 AM"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @objc func btnCrossTapped() {
        //delegate?.crossBtnTapped(index: index)
        callBack?(index)
    }
}
