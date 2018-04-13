//
//  MotionHeaderTableViewCell.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 13/4/18.
//  Copyright © 2018 Stephen OHara. All rights reserved.
//

import UIKit

class MotionHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        resetButton.layer.cornerRadius = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onReset(_ sender: Any) {
        
        if(titleLabel.text == "Motion"){
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "motionReset"),
                object: nil,
                userInfo: nil)
        }
    }
}
