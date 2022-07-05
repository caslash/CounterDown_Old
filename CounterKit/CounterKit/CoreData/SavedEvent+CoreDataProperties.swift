//
//  SavedEvent+CoreDataProperties.swift
//  CounterKit
//
//  Created by Cameron Slash on 28/6/22.
//
//

import CoreData
import Foundation
import SwiftUI

#if canImport(UIKit)
extension SavedEvent {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedEvent> {
        return NSFetchRequest<SavedEvent>(entityName: "SavedEvent")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var due: Date?
    @NSManaged public var colorHex: String?
    @NSManaged public var components: Data?

    public var wrappedId: UUID { id ?? UUID() }
    private var wrappedName: String { name ?? "Unknown Event Name" }
    private var wrappedDue: Date { due ?? Date() }
    private var wrappedColor: Color {
        if let colorHex = colorHex {
            return Color(UIColor(hexString: colorHex))
        } else {
            return Color.red
        }
    }
    private var wrappedComponents: Set<Calendar.Component> {
        if let saved_components = components {
            if let decoded = try? JSONDecoder().decode(Set<Calendar.Component>.self, from: saved_components) {
                return decoded
            }
        }
        return [.day, .hour, .minute, .second]
    }
    
    public var wrappedEvent: Event {
        return Event(id: wrappedId, name: wrappedName, due: wrappedDue, color: wrappedColor, components: wrappedComponents)
    }
    
    public static var previewSavedEvent: SavedEvent {
        let nyd = PreviewEvents.nyd
        let viewContext = DataController.preview.container.viewContext
        let event = SavedEvent(context: viewContext)
        event.id = nyd.id
        event.name = nyd.name
        event.due = nyd.due
        event.colorHex = UIColor(nyd.color).toHexString()
        event.components = try? JSONEncoder().encode(nyd.components)
        return event
    }
}

extension SavedEvent : Identifiable {

}
#elseif canImport(AppKit)
extension SavedEvent {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedEvent> {
        return NSFetchRequest<SavedEvent>(entityName: "SavedEvent")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var due: Date?
    @NSManaged public var colorHex: String?
    @NSManaged public var components: Data?

    public var wrappedId: UUID { id ?? UUID() }
    private var wrappedName: String { name ?? "Unknown Event Name" }
    private var wrappedDue: Date { due ?? Date() }
    private var wrappedColor: Color {
        if let colorHex = colorHex {
            return Color(NSColor(hexString: colorHex))
        } else {
            return Color.red
        }
    }
    private var wrappedComponents: Set<Calendar.Component> {
        if let saved_components = components {
            if let decoded = try? JSONDecoder().decode(Set<Calendar.Component>.self, from: saved_components) {
                return decoded
            }
        }
        return [.day, .hour, .minute, .second]
    }
    
    public var wrappedEvent: Event {
        return Event(id: wrappedId, name: wrappedName, due: wrappedDue, color: wrappedColor, components: wrappedComponents)
    }
    
    public static var previewSavedEvent: SavedEvent {
        let nyd = PreviewEvents.nyd
        let viewContext = DataController.preview.container.viewContext
        let event = SavedEvent(context: viewContext)
        event.id = nyd.id
        event.name = nyd.name
        event.due = nyd.due
        event.colorHex = NSColor(nyd.color).toHexString()
        event.components = try? JSONEncoder().encode(nyd.components)
        return event
    }
}

extension SavedEvent : Identifiable {

}
#endif
