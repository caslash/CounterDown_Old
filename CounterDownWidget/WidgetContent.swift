//
//  WidgetContent.swift
//  CounterDown
//
//  Created by Cameron Slash on 18/6/22.
//

import Foundation
import WidgetKit

struct WidgetContent: TimelineEntry {
    var date = Date()
    var event: Event
    
    let calendar = Calendar.current
    var components: DateComponents {
        return calendar.dateComponents(self.event.components, from: self.date, to: self.event.due)
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
    func minutesLeft() -> String {
        return String(format: "%02d", self.components.minute ?? 00)
    }
    func secondsLeft() -> String {
        return String(format: "%02d", self.components.second ?? 00)
    }
}
