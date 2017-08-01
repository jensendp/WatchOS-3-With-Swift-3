//
//  Stage.swift
//  RemindMe
//
//  Created by Derek Jensen on 7/28/17.
//  Copyright © 2017 Derek Jensen. All rights reserved.
//

import Foundation

class Stage: SecondsContainer {
    var name: String
    var seconds: Int
    
    init(name: String, seconds: Int) {
        self.name = name
        self.seconds = seconds
    }
}
