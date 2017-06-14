//
//  TouchTableViewCell.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 14/6/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import UIKit

class TouchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onTouchDownButton(_ sender: Any) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: titleLabel.text! + "_touched"),
            object: nil,
            userInfo: ["value":1.0])
        
    }
    @IBAction func onTouchUpButton(_ sender: Any) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: titleLabel.text! + "_touched"),
            object: nil,
            userInfo: ["value":0.0])
    }
}
