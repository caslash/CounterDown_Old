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
}
