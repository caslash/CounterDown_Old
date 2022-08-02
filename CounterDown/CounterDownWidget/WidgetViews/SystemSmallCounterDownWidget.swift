//
//  SystemSmallCounterDownWidget.swift
//  CounterDown
//
//  Created by Cameron Slash on 21/6/22.
//

import CounterKit
import SwiftUI
import WidgetKit

@available(iOS 16.0, *)
struct GradientSystemSmallCounterDownWidget: View {
    var entry: Provider.Entry
    var components: DateComponents { Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date(), to: self.entry.event.eventDueDate) }
    
    var body: some View {
        ZStack {
            GeometryReader { metrics in
                EventView(self.entry.event, components: self.components)
                    .padding()
                    .frame(width: metrics.size.width, height: metrics.size.height)
                    .background(self.entry.event.eventColor.gradient)
                    .foregroundColor(UIColor(entry.event.eventColor).isLight() ? .black : .white)
            }
        }
    }
}

struct FlatSystemSmallCounterDownWidget: View {
    var entry: Provider.Entry
    var components: DateComponents { Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date(), to: self.entry.event.eventDueDate) }
    
    var body: some View {
        ZStack {
            entry.event.eventColor
            
            EventView(self.entry.event, components: self.components)
                .padding()
        }
        .foregroundColor(UIColor(entry.event.eventColor).isLight() ? .black : .white)
    }
}

struct EventView: View {
    var components: DateComponents
    var eventName: String
    var eventIsWithinNextYear: Bool
    var eventIsWithinNextMonth: Bool
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 10) {
            Text(self.eventName)
                .font(.title3.weight(.black))
                .multilineTextAlignment(.center)
            
            if !eventIsWithinNextYear {
                HStack {
                    VStack {
                        Text(self.yearsLeft())
                            .font(.title3.weight(.black))
                        
                        Text("YR")
                            .font(.subheadline.weight(.semibold))
                    }
                    
                    VStack {
                        Text(self.monthsLeft())
                            .font(.title3.weight(.black))
                        
                        Text("MTH")
                            .font(.subheadline.weight(.semibold))
                    }
                    
                    VStack {
                        Text(self.daysLeft())
                            .font(.title3.weight(.black))
                        
                        Text("DAY")
                            .font(.subheadline.weight(.semibold))
                    }
                }
            } else if !eventIsWithinNextMonth {
                HStack {
                    VStack {
                        Text(self.monthsLeft())
                            .font(.title3.weight(.black))
                        
                        Text("MTH")
                            .font(.subheadline.weight(.semibold))
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
            } else {
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
    
    init(_ event: SavedEvent, components: DateComponents) {
        self.components = components
        self.eventName = event.eventName
        self.eventIsWithinNextYear = Calendar.current.isDateInNextYear(event.eventDueDate)
        self.eventIsWithinNextMonth =  Calendar.current.isDateInNextMonth(event.eventDueDate)
    }
    
    func yearsLeft() -> String { String(format: "%01d", self.components.year ?? 00) }
    func monthsLeft() -> String { String(format: "%02d", self.components.month ?? 00) }
    func daysLeft() -> String { String(format: "%02d", self.components.day ?? 00) }
    func hoursLeft() -> String { String(format: "%02d", self.components.hour ?? 00) }
}


struct SystemSmallCounterDownWidget_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            GradientSystemSmallCounterDownWidget(entry: SimpleEntry(date: Date(), event: SavedEvent.exampleEvent))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        } else {
            FlatSystemSmallCounterDownWidget(entry: SimpleEntry(date: Date(), event: SavedEvent.exampleEvent))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
