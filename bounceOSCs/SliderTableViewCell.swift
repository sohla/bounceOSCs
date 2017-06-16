//
//  SliderTableViewCell.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 16/6/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSliderChanged(_ sender: UISlider) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: titleLabel.text! + "_changed"),
            object: nil,
            userInfo: ["value":Double(sender.value)])
    }
}
