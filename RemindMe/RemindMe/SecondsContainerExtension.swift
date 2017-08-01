//
//  SecondsContainerExtension.swift
//  RemindMe
//
//  Created by Derek Jensen on 7/28/17.
//  Copyright © 2017 Derek Jensen. All rights reserved.
//

import Foundation

extension SecondsContainer {
    var duration: String? {
        let interval = TimeInterval(seconds)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        let val = formatter.string(from: interval)
        return val
    }
}
