//
//  AddEvent_ViewModel.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import Foundation
import SwiftUI
import EventKit

class AddEventViewModel: ObservableObject {
    @ObservedObject var modeldata = ModelData.shared

    @Published var name: String = String()
    @Published var due: Date = Date()
    @Published var color: Color = .red
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
        let newEvent = Event(name: self.name, due: self.due, color: self.color, components: self.components)
        modeldata.savedEvents.append(newEvent)
    }
    
    func getCalendarEvents() -> [EKEvent]? {
        if modeldata.calendarAccessGranted {
            let today = Date()
            var dateComponents = DateComponents()
            dateComponents.year = 1
            
            let predicate = modeldata.ekstore.predicateForEvents(withStart: today, end: Calendar.current.date(byAdding: dateComponents, to: today)!, calendars: Array(modeldata.userSelectedCalendars))
            
            return modeldata.ekstore.events(matching: predicate)
        }
        
        return nil
    }
}
