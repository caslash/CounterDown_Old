//
//  Event_ViewModel.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import CounterKit
import Foundation

class EventViewModel: ObservableObject {
    @Published var event: SavedEvent
    @Published var now: Date
    
    let calendar = Calendar.current
    var components: DateComponents {
        return calendar.dateComponents(Set(self.event.eventComponents), from: now, to: self.event.eventDueDate)
    }
    
    
    init(event: SavedEvent, now: Date) {
        self.event = event
        self.now = now
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
