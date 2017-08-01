//
//  ReminderRowController.swift
//  RemindMe
//
//  Created by Derek Jensen on 7/31/17.
//  Copyright © 2017 Derek Jensen. All rights reserved.
//

import Foundation
import WatchKit

class ReminderRowController: NSObject {
    @IBOutlet var reminderNameLabel: WKInterfaceLabel!
    @IBOutlet var reminderDurationLabel: WKInterfaceLabel!
    
    var reminder: Reminder? {
        didSet {
            guard let reminder = reminder else { return }
            
            reminderNameLabel.setText(reminder.name)
            reminderDurationLabel.setText(reminder.duration)
        }
    }
}
