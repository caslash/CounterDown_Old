//
//  EditEvent_ViewModel.swift
//  Countdown
//
//  Created by Cameron Slash on 17/6/22.
//

import CounterKit
import CoreData
import Foundation
import SwiftUI

class EditEventViewModel: ObservableObject {
    @Published var event: SavedEvent
    @Published var name: String
    @Published var due: Date
    @Published var color: Color
    @Published var components: Set<Calendar.Component>
    @Published var isRecurring: Bool
    @Published var recurrenceInterval: RecurrenceInterval
    @Published var includeYear: Bool
    @Published var includeMonth: Bool

    init(_ event: SavedEvent) {
        self.event = event
        self.name = event.eventName
        self.due = event.eventDueDate
        self.color = event.eventColor
        self.components = event.eventComponents
        self.isRecurring = event.isRecurring
        self.recurrenceInterval = event.eventRecurrenceInterval
        self.includeYear = event.eventComponents.contains(.year)
        self.includeMonth = event.eventComponents.contains(.month)
    }
    
    func updateEvent() {
        self.event.objectWillChange.send()
        
        if !self.includeYear && self.components.contains(.year) {
            self.components.remove(.year)
        } else if includeYear {
            self.components.insert(.year)
        }
        if !self.includeMonth && self.components.contains(.month) {
            self.components.remove(.month)
        } else if includeMonth {
            self.components.insert(.month)
        }
        
        self.event.name = self.name
        self.event.due = self.due
        self.event.colorHex = UIColor(self.color).toHexString()
        self.event.components = try? JSONEncoder().encode(self.components)
        self.event.isRecurring = self.isRecurring
        if self.isRecurring {
            self.event.recurrenceInterval = Int16(self.recurrenceInterval.rawValue)
        } else {
            self.event.recurrenceInterval = -1
        }
    }
}
