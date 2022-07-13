//
//  AddEvent_ViewModel.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import CounterKit
import Foundation
import SwiftUI
import EventKit

class AddEventViewModel: ObservableObject {
    @Published var name: String = String()
    @Published var due: Date = Date()
    @Published var color: Color = ModelData.shared.accentcolor
    @Published var components: Set<Calendar.Component> = [.day, .hour, .minute, .second]
    @Published var includeYear: Bool = false
    @Published var includeMonth: Bool = false
    
    @Published var calendarEvents: [EKEvent]
    
    init() {
        self.calendarEvents = []
        
        if let userevents = getCalendarEvents() {
            self.calendarEvents = userevents
        }
    }
    
    func addEvent() {
        if includeYear { components.insert(.year) }
        if includeMonth { components.insert(.month) }
        
        let newEvent = SavedEvent(context: DataController.shared.container.viewContext)
        newEvent.id = UUID()
        newEvent.name = self.name
        newEvent.due = self.due
        newEvent.colorHex = UIColor(self.color).toHexString()
        newEvent.components = try? JSONEncoder().encode(self.components)
        DataController.shared.save()
    }
    
    func getCalendarEvents() -> [EKEvent]? {
        if ModelData.shared.calendarAccessGranted && ModelData.shared.userSelectedCalendars.isEmpty {
            let today = Date()
            var dateComponents = DateComponents()
            dateComponents.year = 1
            
            let predicate = ModelData.shared.ekstore.predicateForEvents(withStart: today, end: Calendar.current.date(byAdding: dateComponents, to: today)!, calendars: Array(ModelData.shared.userSelectedCalendars))
            
            return ModelData.shared.ekstore.events(matching: predicate)
        }
        
        return []
    }
}
