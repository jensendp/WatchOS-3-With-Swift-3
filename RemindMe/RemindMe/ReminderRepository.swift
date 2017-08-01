//
//  ReminderRepository.swift
//  RemindMe
//
//  Created by Derek Jensen on 8/1/17.
//  Copyright © 2017 Derek Jensen. All rights reserved.
//

import Foundation

final class ReminderRepository {
    private init() {}
    
    static let instance = ReminderRepository()
    
    func getReminders() -> [Reminder] {
        let reminder = Reminder(name: "Morning Wakeup")
        
        let stage1 = Stage(name: "Stretch", seconds: 5)
        let stage2 = Stage(name: "Light Jog", seconds: 60)
        
        reminder.stages.append(stage1)
        reminder.stages.append(stage2)
        
        let reminder2 = Reminder(name: "Evening Winddown")
        
        let stage3 = Stage(name: "Stretch", seconds: 20)
        let stage4 = Stage(name: "Snack", seconds: 60)
        
        reminder2.stages.append(stage3)
        reminder2.stages.append(stage4)
        
        return [reminder, reminder2]
    }
}
