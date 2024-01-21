//
//  DateService.swift
//  CounterKit
//
//  Created by Cameron Slash on 1/13/24.
//

import Foundation
import Observation

@Observable
public class DateService {
    @ObservationIgnored public static let shared = DateService()
    
    public var now: Date
    
    public var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.now = Date()
        }
    }
    
    init() {
        self.now = Date()
    }
}
