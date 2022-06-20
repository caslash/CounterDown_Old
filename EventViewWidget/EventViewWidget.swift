//
//  EventViewWidget.swift
//  EventViewWidget
//
//  Created by Cameron Slash on 19/6/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> EventEntry {
        EventEntry(date: Date(), event: PreviewEvents.nyd)
    }

    func getSnapshot(in context: Context, completion: @escaping (EventEntry) -> ()) {
        let entry = EventEntry(date: Date(), event: PreviewEvents.nyd)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [EventEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = EventEntry(date: entryDate, event: PreviewEvents.nyd)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct EventViewWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct EventViewWidget: Widget {
    let kind: String = "EventViewWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SmallEventEntryView(entry: EventEntry(event: PreviewEvents.nyd))
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Event")
        .description("See the countdown to your event straight from your homescreen.")
    }
}

struct EventViewWidget_Previews: PreviewProvider {
    static var previews: some View {
        EventViewWidgetEntryView(entry: EventEntry(date: Date(), event: PreviewEvents.nyd))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
