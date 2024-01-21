//
//  PermissionsService.swift
//  CounterKit
//
//  Created by Cameron Slash on 1/13/24.
//

import EventKit
import Foundation
import SlashKit
import SwiftUI
import Observation

@Observable
public class PermissionsService {
    @ObservationIgnored public static let shared = PermissionsService()
    @ObservationIgnored public static let preview = PermissionsService(calendarAccessGranted: true, ekStore: EKEventStore())
    
    @ObservationIgnored public let ekStore: EKEventStore
    @ObservationIgnored public let userDefaults: UserDefaults = UserDefaults(suiteName: "group.Cameron.Slash.CounterDown")!
    
    public var calendarAccessGranted = false {
        didSet {
            if let encoded = try? Utilities.shared.jsonEncoder.encode(calendarAccessGranted) {
                self.userDefaults.set(encoded, forKey: "calendar_access_status")
            }
        }
    }
    
    public var userSelectedCalendars = Set<EKCalendar>() {
        didSet {
            var calendarIDs = [String]()
            for calendar in userSelectedCalendars {
                calendarIDs.append(calendar.calendarIdentifier)
            }
            
            if let encoded = try? Utilities.shared.jsonEncoder.encode(calendarIDs) {
                self.userDefaults.set(encoded, forKey: "user_selected_calendars")
            }
        }
    }
    
    private init() {
        self.ekStore = EKEventStore()
        
        if let calendar_access_status = self.userDefaults.data(forKey: "calendar_access_status") {
            if let decoded = try? Utilities.shared.jsonDecoder.decode(Bool.self, from: calendar_access_status) {
                self.calendarAccessGranted = decoded
            }
        }
        
        if let user_selected_calendars = self.userDefaults.data(forKey: "user_selected_calendars") {
            if let decoded = try? Utilities.shared.jsonDecoder.decode([String].self, from: user_selected_calendars) {
                for id in decoded {
                    if let calendar = ekStore.calendar(withIdentifier: id) {
                        userSelectedCalendars.insert(calendar)
                    }
                }
            }
        }
        
        self.ekStore.requestFullAccessToEvents { granted, error in
            if granted {
                self.calendarAccessGranted = granted
            }
        }
    }
    
    private init(calendarAccessGranted: Bool, ekStore: EKEventStore) {
        self.ekStore = ekStore
        
        self.ekStore.requestFullAccessToEvents { granted, error in
            if granted {
                self.calendarAccessGranted = granted
            }
        }
        
        self.userSelectedCalendars = Set(ekStore.calendars(for: .event))
    }
}
