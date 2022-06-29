//
//  CalendarComponents+Extension.swift
//  Countdown
//
//  Created by Cameron Slash on 27/5/22.
//

import Foundation

extension Calendar.Component: CaseIterable, Codable {
    public static var allCases: [Calendar.Component] {
        return [.era, .year, .yearForWeekOfYear, .quarter, .month, .weekOfYear, .weekOfMonth, .weekday, .weekdayOrdinal, .hour, .minute, .second, .nanosecond, .calendar, .timeZone, .day]
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.name)
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let selectedComponent = try container.decode(String.self)
        
        self = .era
        
        for component in Calendar.Component.allCases {
            if selectedComponent == component.name {
                self = component
            }
        }
    }
    
    public var name: String {
        switch self {
        case .era: return "era"
        case .year: return "year"
        case .yearForWeekOfYear: return "yearForWeekOfYear"
        case .quarter: return "quarter"
        case .month: return "month"
        case .weekOfYear: return "weekOfYear"
        case .weekOfMonth: return "weekOfMonth"
        case .weekday: return "weekday"
        case .weekdayOrdinal: return "weekdayOrdinal"
        case .hour: return "hour"
        case .minute: return "minute"
        case .second: return "second"
        case .nanosecond: return "nanosecond"
        case .calendar: return "calendar"
        case .timeZone: return "timeZone"
        case .day: return "day"
        @unknown default: return "unknown"
        }
    }
}

extension Calendar {
    private var currentDate: Date { Date() }
    
    public func isDateInNextYear(_ date: Date) -> Bool {
        guard let nextYear = self.date(byAdding: DateComponents(year: 1), to: currentDate) else {
            return false
        }
        
        return date < nextYear
    }
    
    public func isDateInNextMonth(_ date: Date) -> Bool {
        guard let nextMonth = self.date(byAdding: DateComponents(month: 1), to: currentDate) else {
            return false
        }
        
        return date < nextMonth
    }
}
