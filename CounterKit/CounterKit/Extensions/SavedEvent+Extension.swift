//
//  SavedEvent+Extension.swift
//  CounterKit
//
//  Created by Cameron Slash on 12/7/22.
//

import CoreData
import Foundation
import SwiftUI

extension SavedEvent: Comparable {
    public static var exampleEvent: SavedEvent {
        let controller = DataController.shared
        let vc = controller.container.viewContext
        
        let components: [Calendar.Component] = [.day, .hour, .minute, .second]
        
        let event = SavedEvent(context: vc)
        event.id = UUID()
        event.name = "New Years Day"
        event.due = Date(timeIntervalSince1970: 1672549200)
        event.colorHex = UIColor(.green).toHexString()
        event.components = try? JSONEncoder().encode(components)
        event.isRecurring = true
        event.recurrenceInterval = Int16(RecurrenceInterval.yearly.rawValue)
        
        return event
    }
    
    public static func < (lhs: SavedEvent, rhs: SavedEvent) -> Bool {
        return lhs.eventDueDate < rhs.eventDueDate
    }
    
    public static func getSavedEventFetchRequest() -> NSFetchRequest<SavedEvent> {
        let request = SavedEvent.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(SavedEvent.due), ascending: true)]
        return request
    }
    
    public var eventId: UUID { id ?? UUID() }
    public var eventName: String { name ?? "New Event" }
    public var eventDueDate: Date { due ?? Date() }
    #if canImport(UIKit)
    public var eventColor: Color {
        if let colorHex {
            return Color(UIColor(hexString: colorHex))
        }
        return .green
    }
    #elseif canImport(AppKit)
    public var eventColor: Color {
        if let colorHex {
            return Color(NSColor(hexString: colorHex))
        }
        return .green
    }
    #endif
    public var eventComponents: Set<Calendar.Component> {
        if let components {
            do {
                return try JSONDecoder().decode(Set<Calendar.Component>.self, from: components)
            } catch {
                fatalError("Failed to deserialize event components: \(error.localizedDescription)")
            }
        }
        return Set([.day, .hour, .minute, .second])
    }
    public var eventRecurrenceInterval: RecurrenceInterval {
        RecurrenceInterval(rawValue: Int(recurrenceInterval)) ?? .none
    }
    
    public static func eventFromId(_ id: UUID) -> SavedEvent? {
        let request = NSFetchRequest<SavedEvent>(entityName: "SavedEvent")
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        let savedevents = try? DataController.shared.container.viewContext.fetch(request)
        return savedevents?.first
    }
}
