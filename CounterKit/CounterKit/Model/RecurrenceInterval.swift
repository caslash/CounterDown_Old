//
//  RecurrenceInterval.swift
//  CounterKit
//
//  Created by Cameron Slash on 1/14/24.
//

import Foundation

public enum RecurrenceInterval: Int, CaseIterable, Codable {
    case none = 0, daily, weekly, biweekly, monthly, yearly
}

extension RecurrenceInterval {
    public var displayName: String {
        switch self {
        case .none:
            return "None"
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .biweekly:
            return "Biweekly"
        case .monthly:
            return "Monthly"
        case .yearly:
            return "Yearly"
        }
    }
    
    public var component: Calendar.Component? {
        switch self {
        case .none:
            return nil
        case .daily:
            return .day
        case .weekly, .biweekly:
            return .weekOfYear
        case .monthly:
            return .month
        case .yearly:
            return .year
        }
    }
    
    public var offet: Int {
        switch self {
        case .none:
            return 0
        case .biweekly:
            return 2
        case .daily, .weekly, .monthly, .yearly:
            return 1
        }
    }
}
