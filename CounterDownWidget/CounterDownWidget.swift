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
        let selectedEvent = eventFromId(UUID(uuidString: (configuration.event?.identifier)!))

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, event: selectedEvent)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func eventFromId(_ id: UUID?) -> Event {
       let userdefaults = UserDefaults(suiteName: "group.Cameron.Slash.CounterDown")!
       if let saved_events = userdefaults.data(forKey: "saved_events") {
           if let decoded = try? JSONDecoder().decode([Event].self, from: saved_events) {
               if let event = decoded.first(where: { $0.id == id }) {
                   return event
               }
           }
       }
       
       return PreviewEvents.nyd
   }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    let event: Event
}

struct SmallCounterDownWidgetEntryView: View {
    var entry: Provider.Entry
    var calendar = Calendar.current
    var components: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date(), to: self.entry.event.due)
    }
    
    @ViewBuilder
    var body: some View {
        if #available(iOS 16.0, *) {
            VStack {
                Spacer()
                
                Text(entry.event.name)
                    .font(.title3.weight(.black))
                    .multilineTextAlignment(.center)
                
                HStack {
                    Spacer()
                    
                    if !Calendar.current.isDate(entry.event.due, equalTo: Calendar.current.date(byAdding: DateComponents(month: 1), to: Date())!, toGranularity: .month) {
                        VStack {
                            Text(self.monthsLeft())
                                .font(.title3.weight(.black))
                            
                            Text("MTH")
                                .font(.subheadline.weight(.semibold))
                        }
                    }
                    
                    VStack {
                        Text(self.daysLeft())
                            .font(.title3.weight(.black))
                        
                        Text("DAY")
                            .font(.subheadline.weight(.semibold))
                    }
                    
                    VStack {
                        Text(self.hoursLeft())
                            .font(.title3.weight(.black))
                        
                        Text("HRS")
                            .font(.subheadline.weight(.semibold))
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .background(entry.event.color.gradient)
        } else {
            ZStack {
                entry.event.color
                
                VStack {
                    Text(entry.event.name)
                        .font(.title3.weight(.black))
                        .multilineTextAlignment(.center)
                    
                    
                    HStack {
                        
                        if Calendar.current.isDate(entry.event.due, equalTo: Calendar.current.date(byAdding: DateComponents(year: 1), to: Date())!, toGranularity: .year) {
                            VStack {
                                Text(self.monthsLeft())
                                    .font(.title3.weight(.black))
                                
                                Text("MTH")
                                    .font(.subheadline.weight(.semibold))
                            }
                        }
                        
                        if Calendar.current.isDate(entry.event.due, equalTo: Calendar.current.date(byAdding: DateComponents(month: 1), to: Date())!, toGranularity: .month) {
                            VStack {
                                Text(self.monthsLeft())
                                    .font(.title3.weight(.black))
                                
                                Text("MTH")
                                    .font(.subheadline.weight(.semibold))
                            }
                        }
                        
                        VStack {
                            Text(self.daysLeft())
                                .font(.title3.weight(.black))
                            
                            Text("DAY")
                                .font(.subheadline.weight(.semibold))
                        }
                        
                        VStack {
                            Text(self.hoursLeft())
                                .font(.title3.weight(.black))
                            
                            Text("HR")
                                .font(.subheadline.weight(.semibold))
                        }
                    }
                }
            }
        }
    }
    func monthsLeft() -> String {
        return String(format: "%02d", self.components.month ?? 00)
    }
    func daysLeft() -> String {
        return String(format: "%02d", self.components.day ?? 00)
    }
    func hoursLeft() -> String {
        return String(format: "%02d", self.components.hour ?? 00)
    }
}

struct MediumCounterDownWidgetEntryView: View {
    var entry: Provider.Entry
    var calendar = Calendar.current
    var components: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date(), to: self.entry.event.due)
    }
    
    @ViewBuilder
    var body: some View {
        Text("Hello, World")
    }
}

struct LockScreenCounterDownWidgetEntryView: View {
    var entry: Provider.Entry
    var calendar = Calendar.current
    var components: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date(), to: self.entry.event.due)
    }
    var eventIsInNextYear: Bool {
        calendar.isDateInNextYear(self.entry.event.due)
    }
    var eventIsInNextMonth: Bool {
        calendar.isDateInNextMonth(self.entry.event.due)
    }
    var timeLeftString: String {
        if !eventIsInNextYear {
            return "\(self.yearsLeft()) years \(self.monthsLeft()) months"
        } else if !eventIsInNextMonth {
            return "\(self.monthsLeft()) months \(self.daysLeft()) days"
        } else {
            return "\(self.daysLeft()) days \(self.hoursLeft()) hours"
        }
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
            Text(entry.event.name)
                .fontWeight(.bold)
            
            Text(timeLeftString)
        }
    }
    
    func yearsLeft() -> String {
        return String(format: "%01d", self.components.year ?? 00)
    }
    func monthsLeft() -> String {
        return String(format: "%01d", self.components.month ?? 00)
    }
    func daysLeft() -> String {
        return String(format: "%01d", self.components.day ?? 00)
    }
    func hoursLeft() -> String {
        return String(format: "%01d", self.components.hour ?? 00)
    }
}

struct CounterDownWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallCounterDownWidgetEntryView(entry: entry)
                .foregroundColor(UIColor(entry.event.color).isLight() ? .black : .white)
        case .accessoryRectangular:
            LockScreenCounterDownWidgetEntryView(entry: entry)
        default:
            MediumCounterDownWidgetEntryView(entry: entry)
                .foregroundColor(UIColor(entry.event.color).isLight() ? .black : .white)
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
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
