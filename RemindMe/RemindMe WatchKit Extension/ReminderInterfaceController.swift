//
//  ReminderInterfaceController.swift
//  RemindMe
//
//  Created by Derek Jensen on 7/31/17.
//  Copyright © 2017 Derek Jensen. All rights reserved.
//

import WatchKit
import Foundation


enum ReminderStates {
    case Ready
    case Running
    case StageDone
    case Done
}

class ReminderInterfaceController: WKInterfaceController {

    @IBOutlet var reminderNameLabel: WKInterfaceLabel!
    @IBOutlet var reminderDurationLabel: WKInterfaceLabel!
    @IBOutlet var stageNameLabel: WKInterfaceLabel!
    @IBOutlet var interfaceTimer: WKInterfaceTimer!
    
    
    @IBOutlet var actionButton: WKInterfaceButton!
    
    @IBAction func actionButtonClicked() {
        switch state {
            
        case .Ready:
            start()
        case .Running:
            endStage()
        case .StageDone:
            advance()
        case .Done:
            reset()
            
        }
    }
    
    private var timer: Timer?
    private var state = ReminderStates.Ready
    private var activeStageIndex = 0
    
    private var activeStage: Stage? {
        didSet {
            guard let stage = activeStage else { return }
            
            stageNameLabel.setText(stage.name)
            let interval = TimeInterval(exactly: (activeStage?.seconds)!)
            let date = Date(timeIntervalSinceNow: interval!)
            interfaceTimer.setDate(date)
        }
    }
    
    var activeReminder: Reminder? {
        didSet {
            guard let reminder = activeReminder else { return }
            
            reminderNameLabel.setText(reminder.name)
            reminderDurationLabel.setText(reminder.duration)
            
            if reminder.stages.count >= activeStageIndex {
                let stage = reminder.stages[activeStageIndex]
                activeStage = stage
            }
        }
    }
    
    private func start() {
        state = .Running
        actionButton.setTitle("End Stage")
        let interval = TimeInterval(exactly: (activeStage?.seconds)!)
        interfaceTimerReset(timer: interfaceTimer, interval: interval!)
        timer = Timer.scheduledTimer(timeInterval: interval!, target: self, selector: #selector(ReminderInterfaceController.timerEnded(timer:)), userInfo: nil, repeats: false)
    }
    
    private func endStage() {
        state = .StageDone
        actionButton.setTitle("Next Stage")
        interfaceTimer.stop()
        let now = Date(timeIntervalSinceNow: 0)
        interfaceTimer.setDate(now)
        timer?.invalidate()
    }
    
    private func advance() {
        activeStageIndex += 1
        if (activeReminder?.stages.count)! > activeStageIndex {
            let stage = activeReminder?.stages[activeStageIndex]
            activeStage = stage
            state = .Ready
            actionButton.setTitle("Start")
        } else {
            actionButton.setTitle("Reset")
            state = .Done
        }
    }
    
    private func reset() {
        state = .Ready
        activeStage = activeReminder?.stages[0]
        actionButton.setTitle("Start")
    }
    
    func timerEnded(timer: Timer) {
        interfaceTimer.stop()
        timer.invalidate()
        WKInterfaceDevice.current().play(.stop)
        state = .StageDone
        actionButton.setTitle("Next Stage")
    }
    
    private func interfaceTimerReset(timer: WKInterfaceTimer, interval: TimeInterval) {
        timer.stop()
        let time = Date(timeIntervalSinceNow: interval)
        timer.setDate(time)
        timer.start()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        if let reminder = context as? Reminder {
            self.activeReminder = reminder
        }
        
        actionButton.setTitle("Start")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
