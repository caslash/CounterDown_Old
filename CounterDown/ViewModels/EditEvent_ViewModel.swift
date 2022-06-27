//
//  EditEvent_ViewModel.swift
//  Countdown
//
//  Created by Cameron Slash on 17/6/22.
//

import CoreData
import Foundation
import SwiftUI

class EditEventViewModel: ObservableObject {
    @ObservedObject var modeldata = ModelData.shared

    @Published var eventId: UUID
    @Published var name: String
    @Published var due: Date
    @Published var color: Color
    @Published var components: Set<Calendar.Component>
    @Published var includeYear: Bool
    @Published var includeMonth: Bool

    init(_ event: Event) {
        self.eventId = event.id
        self.name = event.name
        self.due = event.due
        self.color = event.color
        self.components = event.components
        self.includeYear = event.components.contains(.year)
        self.includeMonth = event.components.contains(.month)
    }
    
    func editEvent() {
        if !includeYear && components.contains(.year) {
            components.remove(.year)
        } else if includeYear {
            components.insert(.year)
        }
        if !includeMonth && components.contains(.month) {
            components.remove(.month)
        } else if includeMonth {
            components.insert(.month)
        }
        let updatedEvent = Event(id: self.eventId, name: self.name, due: self.due, color: self.color, components: self.components)
        self.modeldata.updateEvent(updatedEvent)
        self.modeldata.saveMoc()
    }
}
