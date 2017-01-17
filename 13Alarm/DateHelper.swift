//
//  DateHelper.swift
//  13Alarm
//
//  Created by Andrew Drechsel on 1/16/17.
//  Copyright © 2017 Andrew Drechsel. All rights reserved.
//

import UIKit

enum DateHelper {
    
    static var thisMorningAtMidnight: Date? {
        
        let calendar = Calendar.current
        let now = Date()
        return (calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now))
    }
    
    static var tomorrowMorningAtMidnight: Date? {
        
        let calendar = Calendar.current
        guard let thisMorningAtMidnight = thisMorningAtMidnight else { return nil }
        return (calendar.date(byAdding: .day, value: 1, to: thisMorningAtMidnight))
        
    }
}
