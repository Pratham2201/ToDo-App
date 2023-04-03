//
//  SettingViewCell.swift
//  Todo
//
//  Created by Pratham Gupta on 08/03/23.
//

import UIKit

class SettingViewCell: UITableViewCell {

    @IBOutlet weak var cardSetting: UIView!
    @IBOutlet weak var lblSetting: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        cardSetting.layer.cornerRadius = 4
        cardSetting.layer.borderWidth = 0.2
        cardSetting.layer.borderColor = CGColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        lblSetting.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        
    }

}
