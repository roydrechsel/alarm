//
//  SwitchTableViewCell.swift
//  13Alarm
//
//  Created by Andrew Drechsel on 1/14/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}



class SwitchTableViewCell: UITableViewCell {
    
    @IBAction func switchValueChanged(_ sender: Any) {
        
     delegate?.switchCellSwitchValueChanged(cell: self)
        
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    var alarm: Alarm? {
        
        didSet {
            
            guard let alarm = alarm else { return }
            timeLabel.text = alarm.fireTimeAsString
            nameLabel.text = alarm.name
            alarmSwitch.isOn = alarm.enabled
            
        }
    }
}


