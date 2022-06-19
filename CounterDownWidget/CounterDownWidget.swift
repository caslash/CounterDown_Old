//
//  CounterDownWidget.swift
//  CounterDownWidget
//
//  Created by Cameron Slash on 18/6/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let snapshotEntry = WidgetContent(event: PreviewEvents.birthday)
    
    func placeholder(in context: Context) -> WidgetContent {
        snapshotEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetContent) -> ()) {
        let entry = snapshotEntry
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [WidgetContent] = []
//
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = WidgetContent(date: entryDate)
//            entries.append(entry)
//        }
        
        let entries = [snapshotEntry]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct CounterDownWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        EntryView(model: entry)
    }
}

@main
struct CounterDownWidget: Widget {
    let kind: String = "CounterDownWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CounterDownWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Event")
        .description("See the countdown to your event.")
    }
}

struct CounterDownWidget_Previews: PreviewProvider {
    static var previews: some View {
        CounterDownWidgetEntryView(entry: WidgetContent(date: Date(), event: PreviewEvents.christmas))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
