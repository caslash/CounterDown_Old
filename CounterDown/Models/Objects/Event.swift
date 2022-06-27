//
//  Event.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import Foundation
import SwiftUI

struct Event: Codable, Identifiable {
    var id = UUID()
    var name: String
    var due: Date
    var color: Color
    var components: Set<Calendar.Component>
    
    static func eventFromId(_ id: UUID) -> Event? {
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
}
