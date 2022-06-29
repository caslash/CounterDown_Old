//
//  Preview_Events.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import Foundation
import SwiftUI

public struct PreviewEvents {
    public static let birthday: Event = {
        let name = "My Birthday"
        let due = Date(timeIntervalSince1970: 1658851200)
        let color: Color = .red
        let components: Set<Calendar.Component> = [Calendar.Component.month, Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second]
        return Event(name: name, due: due, color: color, components: components)
    }()
    
    public static let christmas: Event = {
        let name = "Christmas"
        let due = Date(timeIntervalSince1970: 1671987600)
        let color: Color = .green
        let components: Set<Calendar.Component> = [Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second]
        return Event(name: name, due: due, color: color, components: components)
    }()
    
    public static let nyd: Event = {
        let name = "New Years Day"
        let due = Date(timeIntervalSince1970: 1672549200)
        let color: Color = .yellow
        let components: Set<Calendar.Component> = [Calendar.Component.month, Calendar.Component.day, Calendar.Component.hour]
        return Event(name: name, due: due, color: color, components: components)
    }()
    
    public static let events: [Event] = {
       return [birthday, christmas]
    }()
}
