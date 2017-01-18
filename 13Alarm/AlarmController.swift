//
//  AlarmController.swift
//  13Alarm
//
//  Created by Andrew Drechsel on 1/14/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import UIKit

class AlarmController {
    
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []
    
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        
        return alarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        
    }
    
    func toggleEnabled(for alarm: Alarm) {
        
        alarm.enabled = !alarm.enabled
    }
    
    func delete(alarm: Alarm) {
        
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
        
    }
    
    
    var mockAlarms: [Alarm] {

        let fakeAlarm1 = Alarm(fireTimeFromMidnight: 10.0, name: "Fake Alarm 1", enabled: true, uuid: "")

        return [fakeAlarm1]
        
    }
    
//    init(alarm: Alarm) {
//
//        self.alarms = [alarm]
//    }
    
}
