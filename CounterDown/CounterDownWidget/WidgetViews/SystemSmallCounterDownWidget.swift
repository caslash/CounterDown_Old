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
    var calendar = Calendar.current
    var components: DateComponents { calendar.dateComponents([.year, .month, .day, .hour], from: Date(), to: self.entry.event.eventDueDate) }
    var eventIsWithinNextYear: Bool { calendar.isDateInNextYear(self.entry.event.eventDueDate) }
    var eventIsWithinNextMonth: Bool { calendar.isDateInNextMonth(self.entry.event.eventDueDate) }
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            Text(entry.event.eventName)
                .font(.title3.weight(.black))
                .multilineTextAlignment(.center)
            
            HStack {
                Spacer()
                
                getTimeLeftView()
                
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .background(entry.event.eventColor.gradient)
        .foregroundColor(UIColor(entry.event.eventColor).isLight() ? .black : .white)
    }
    
    @ViewBuilder
    func getTimeLeftView() -> some View {
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
    
    func yearsLeft() -> String { String(format: "%01d", self.components.year ?? 00) }
    func monthsLeft() -> String { String(format: "%02d", self.components.month ?? 00) }
    func daysLeft() -> String { String(format: "%02d", self.components.day ?? 00) }
    func hoursLeft() -> String { String(format: "%02d", self.components.hour ?? 00) }
}

struct FlatSystemSmallCounterDownWidget: View {
    var entry: Provider.Entry
    var calendar = Calendar.current
    var components: DateComponents { calendar.dateComponents([.year, .month, .day, .hour], from: Date(), to: self.entry.event.eventDueDate) }
    var eventIsWithinNextYear: Bool { calendar.isDateInNextYear(self.entry.event.eventDueDate) }
    var eventIsWithinNextMonth: Bool { calendar.isDateInNextMonth(self.entry.event.eventDueDate) }
    
    var body: some View {
        ZStack {
            entry.event.eventColor
            
            VStack(spacing: 10) {
                Text(entry.event.eventName)
                    .font(.title3.weight(.black))
                    .multilineTextAlignment(.center)
                
                getTimeLeftView()
            }
            .padding()
        }
        .foregroundColor(UIColor(entry.event.eventColor).isLight() ? .black : .white)
    }
    
    @ViewBuilder
    func getTimeLeftView() -> some View {
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
