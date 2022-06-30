//
//  Event.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import Foundation
import SwiftUI

public struct Event: Codable, Identifiable {
    public var id = UUID()
    public var name: String
    public var due: Date
    public var color: Color
    public var components: Set<Calendar.Component>
    
    public static func eventFromId(_ id: UUID) -> Event? {
        if let savedEvents = try? DataController.shared.container.viewContext.fetch(SavedEvent.fetchRequest()) {
            if let savedEvent = savedEvents.first(where: { $0.wrappedId == id }) {
                return savedEvent.wrappedEvent
            }
        }
        return nil
    }
    
    public init(id: UUID = UUID(), name: String, due: Date, color: Color, components: Set<Calendar.Component>) {
        self.id = id
        self.name = name
        self.due = due
        self.color = color
        self.components = components
    }
}
