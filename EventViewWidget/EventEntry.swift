//
//  EventEntry.swift
//  CounterDown
//
//  Created by Cameron Slash on 19/6/22.
//

import Foundation
import WidgetKit

struct EventEntry: TimelineEntry {
    var date = Date()
    var event: Event
    
    let calendar = Calendar.current
    var components: DateComponents {
        calendar.dateComponents([.year, .month, .day, .hour], from: self.date, to: self.event.due)
    }
    
    func yearsLeft() -> String {
        return String(format: "%02d", self.components.year ?? 00)
    }
    func monthsLeft() -> String {
        return String(format: "%02d", self.components.month ?? 00)
    }
    func daysLeft() -> String {
        return String(format: "%02d", self.components.day ?? 00)
    }
    func hoursLeft() -> String {
        return String(format: "%02d", self.components.hour ?? 00)
    }
}
