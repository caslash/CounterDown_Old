//
//  AccessoryRectangularCounterDownWidget.swift
//  CounterDown
//
//  Created by Cameron Slash on 21/6/22.
//

import CounterKit
import SwiftUI
import WidgetKit

@available(iOS 16.0, *)
struct AccessoryRectangularCounterDownWidget: View {
    var entry: Provider.Entry
    var calendar = Calendar.current
    var components: DateComponents { calendar.dateComponents([.year, .month, .day, .hour], from: Date(), to: self.entry.event.due) }
    var eventIsWithinNextYear: Bool { calendar.isDateInNextYear(self.entry.event.due) }
    var eventIsWithinNextMonth: Bool { calendar.isDateInNextMonth(self.entry.event.due) }
    
    var body: some View {
        VStack {
            Text(self.entry.event.name)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(self.getTimeLeftString())
        }
    }
    
    func getTimeLeftString() -> String {
        if !eventIsWithinNextYear {
            return "\(self.yearsLeft()) years \(self.monthsLeft()) months"
        } else if !eventIsWithinNextMonth {
            return "\(self.monthsLeft()) months \(self.daysLeft()) days"
        } else {
            return "\(self.daysLeft()) days \(self.hoursLeft()) hours"
        }
    }
    
    func yearsLeft() -> String { String(format: "%01d", self.components.year ?? 00) }
    func monthsLeft() -> String { String(format: "%01d", self.components.month ?? 00) }
    func daysLeft() -> String { String(format: "%01d", self.components.day ?? 00) }
    func hoursLeft() -> String { String(format: "%01d", self.components.hour ?? 00) }
}

@available(iOS 16.0, *)
struct AccessoryRectangularCounterDownWidget_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryRectangularCounterDownWidget(entry: SimpleEntry(date: Date(), event: PreviewEvents.nyd))
    }
}
