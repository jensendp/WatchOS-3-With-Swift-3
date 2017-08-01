//
//  Reminder.swift
//  RemindMe
//
//  Created by Derek Jensen on 7/28/17.
//  Copyright © 2017 Derek Jensen. All rights reserved.
//

import Foundation

class Reminder: SecondsContainer {
    var name: String
    var stages = [Stage]()
    
    init(name: String) {
        self.name = name
    }
    
    var seconds: Int {
        var numberOfSeconds = 0
        
        for stage in stages {
            numberOfSeconds += stage.seconds
        }
        
        return numberOfSeconds
    }
}
