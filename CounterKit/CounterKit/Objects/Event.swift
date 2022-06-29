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
        let userdefaults = UserDefaults(suiteName: "group.Cameron.Slash.CounterDown")!
        if let savedevents = userdefaults.data(forKey: "saved_events") {
            if let events = try? JSONDecoder().decode([Event].self, from: savedevents) {
                if let event = events.first(where: { $0.id == id }) {
                    return event
                }
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
