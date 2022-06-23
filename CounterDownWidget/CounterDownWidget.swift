//
//  CounterDownWidget.swift
//  CounterDownWidget
//
//  Created by Cameron Slash on 20/6/22.
//

import UIKit
import SwiftUI
import WidgetKit

struct Provider: IntentTimelineProvider {
    typealias Intent = DynamicEventSelectionIntent
    
    public typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), event: PreviewEvents.nyd)
    }

    func getSnapshot(for configuration: DynamicEventSelectionIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), event: PreviewEvents.nyd)
        completion(entry)
    }

    func getTimeline(for configuration: DynamicEventSelectionIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let selectedEvent = event(for: configuration)

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for _ in 0 ..< 4 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, event: selectedEvent)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .after(Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!))
        completion(timeline)
    }
    
    func event(for configuration: DynamicEventSelectionIntent) -> Event {
        if let id = configuration.event?.identifier, let uuid = UUID(uuidString: id), let event = Event.eventFromId(uuid) {
            return event
        }
        return PreviewEvents.nyd
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    let event: Event
}

struct CounterDownWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            if #available(iOS 16.0, *) {
                GradientSystemSmallCounterDownWidget(entry: entry)
            } else {
                FlatSystemSmallCounterDownWidget(entry: entry)
            }
        case .accessoryRectangular:
            if #available(iOS 16.0, *) { AccessoryRectangularCounterDownWidget(entry: entry) }
        default:
            Text(entry.event.name)
        }
    }
}

@main
struct CounterDownWidget: Widget {
    let kind: String = "CounterDownWidget"
    
    var supportedFamilies: [WidgetFamily] {
        if #available(iOS 16.0, *) {
            return [.systemSmall, .accessoryRectangular]
        } else {
            return [.systemSmall]
        }
    }

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: DynamicEventSelectionIntent.self, provider: Provider()) { entry in
            CounterDownWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Event")
        .description("See the countdown to your event from the homescreen.")
        .supportedFamilies(supportedFamilies)
    }
}

@available(iOS 16.0, *)
struct CounterDownWidget_Previews: PreviewProvider {
    static var previews: some View {
        CounterDownWidgetEntryView(entry: SimpleEntry(date: Date(), event: PreviewEvents.nyd))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
