//
//  SensorTableViewCell.swift
//  bounceOSCs
//
//  Created by Stephen OHara on 5/6/17.
//  Copyright © 2017 Stephen OHara. All rights reserved.
//

import UIKit

protocol SensorTableViewCellDelegate : class{
    func onOffSwitchDidChange(_ cell: SensorTableViewCell, state: Bool)
}

class SensorTableViewCell: UITableViewCell {

    @IBOutlet weak var onOffSwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: SensorTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onOffSwitchChanged(_ sender: Any) {
        delegate?.onOffSwitchDidChange(self, state: (sender as! UISwitch).isOn)
    }
}
