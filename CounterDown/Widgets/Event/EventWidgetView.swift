//
//  EventWidgetView.swift
//  WidgetsExtension
//
//  Created by Cameron Slash on 1/17/24.
//

import CounterKit
import SwiftUI
import WidgetKit

struct EventWidgetView: View {
    @Environment(\.widgetFamily) private var family
    var entry: EventWidgetEntry
    
    var body: some View {
        switch family {
        case .systemSmall:
            SystemSmallEventView(event: self.entry.event ?? SavedEvent.example)
                .containerBackground(self.entry.event?.unwrappedColor ?? .blue, for: .widget)
        case .systemMedium:
            SystemMediumEventView(event: self.entry.event ?? SavedEvent.example)
                .containerBackground(self.entry.event?.unwrappedColor ?? .blue, for: .widget)
        default:
            AccessoryRectangularEventView(event: self.entry.event ?? SavedEvent.example)
                .containerBackground(.clear, for: .widget)
        }
    }
}


#Preview("SystemSmall", as: WidgetFamily.systemSmall) {
    EventWidget()
} timeline: {
    EventWidgetEntry(date: .now, event: SavedEvent.example)
}

#Preview("SystemMedium", as: WidgetFamily.systemMedium) {
    EventWidget()
} timeline: {
    EventWidgetEntry(date: .now, event: SavedEvent.example)
}

#if os(iOS)
#Preview("AccessoryRectangular", as: WidgetFamily.accessoryRectangular) {
    EventWidget()
} timeline: {
    EventWidgetEntry(date: .now, event: SavedEvent.example)
}
#endif
