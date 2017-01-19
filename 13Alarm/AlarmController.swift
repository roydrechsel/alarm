//
//  AlarmController.swift
//  13Alarm
//
//  Created by Andrew Drechsel on 1/14/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import UIKit
import Foundation

class AlarmController {
    
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []
    
    init() {
        loadFromPersistentStorage()
    }
    
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        saveToPersistentStorage()
        
        return alarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        saveToPersistentStorage()
        
    }
    
    func toggleEnabled(for alarm: Alarm) {
        
        alarm.enabled = !alarm.enabled
        saveToPersistentStorage()
    }
    
    func delete(alarm: Alarm) {
        
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
        saveToPersistentStorage()
        
    }
    
    
    private func saveToPersistentStorage() {
        
        guard let filePath = type(of: self).persistentAlarmsFilePath else { return }
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: filePath)

    }
    
    private func loadFromPersistentStorage() {
        
        guard let filePath = type(of: self).persistentAlarmsFilePath else { return }
        guard let alarms = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Alarm] else { return }
        self.alarms = alarms
    }
    
    
    static private var persistentAlarmsFilePath: String? {
        
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        guard let documentsDirectory = directories.first as NSString? else { return nil }
        return documentsDirectory.appendingPathComponent("Alarms.plist")
        
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

protocol AlarmScheduler {
    
    func scheduleLocalNotification(for alarm: Alarm)
    func cancelLocalNotification(for alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleLocalNotification(for alarm: Alarm) {
        
        let localNotification = UILocalNotification()
        localNotification.userInfo = ["UUID" : alarm.uuid]
        localNotification.alertTitle = "This is your alarm speaking!"
        localNotification.alertBody = "Your \(alarm.name) is done!"
        localNotification.fireDate = alarm.fireDate as Date?
        localNotification.repeatInterval = .day
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    func cancelLocalNotification(for alarm: Alarm) {
        
        guard let scheduledNotifications = UIApplication.shared.scheduledLocalNotifications else { return }
        for notification in scheduledNotifications {
            guard let uuid = notification.userInfo?["UUID"] as? String,
                uuid == alarm.uuid else { continue }
            UIApplication.shared.cancelLocalNotification(notification)
        }
    }
}





