//
//  RecurrenceInterval.swift
//  CounterKit
//
//  Created by Cameron Slash on 12/7/22.
//

import Foundation

public enum RecurrenceInterval: Int, CaseIterable {
    case none = 0, daily, weekly, biweekly, monthly, yearly
}

extension RecurrenceInterval {
    public var displayName: String {
        switch self {
        case.none:
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
        case .weekly:
            return .weekOfYear
        case .biweekly:
            return .weekOfYear
        case .monthly:
            return .month
        case .yearly:
            return .year
        }
    }
    
    public var offset: Int {
        switch self {
        case .none:
            return 0
        case .biweekly:
            return 2
        default:
            return 1
        }
    }
}
