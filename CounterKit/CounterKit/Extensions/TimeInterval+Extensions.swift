//
//  TimeInterval+Extensions.swift
//  CounterKit
//
//  Created by Cameron Slash on 1/17/24.
//

import Foundation

public extension TimeInterval {
    init(days: Double = 0, hours: Double = 0, minutes: Double = 0, seconds: Double = 0) {
        self = (24 * 60 * 60 * days) + (60 * 60 * hours) + (60 * minutes) + seconds
    }
}
