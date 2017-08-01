//
//  ReminderTableInterfaceController.swift
//  RemindMe
//
//  Created by Derek Jensen on 7/30/17.
//  Copyright © 2017 Derek Jensen. All rights reserved.
//

import WatchKit
import Foundation


class ReminderTableInterfaceController: WKInterfaceController {

    @IBOutlet var remindersTable: WKInterfaceTable!
    var reminders = [Reminder]()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        reminders = ReminderRepository.instance.getReminders()
        remindersTable.setNumberOfRows(reminders.count, withRowType: "ReminderRow")
        
        for index in 0..<remindersTable.numberOfRows {
            guard let controller = remindersTable.rowController(at: index) as? ReminderRowController else { continue }
            
            controller.reminder = reminders[index]
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let reminder = reminders[rowIndex]
        presentController(withName: "Reminder", context: reminder)
    }
}
