//
//  ModelData.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import EventKit
import Foundation

@MainActor class ModelData: ObservableObject {
    static let shared = ModelData()
    let ekstore: EKEventStore
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    @Published var savedEvents = [Event]() {
        didSet {
            if let encoded = try? self.jsonEncoder.encode(savedEvents) {
                UserDefaults.standard.set(encoded, forKey: "saved_events")
            }
        }
    }
    
    @Published var calendarAccessGranted = false {
        didSet {
            if let encoded = try? self.jsonEncoder.encode(calendarAccessGranted) {
                UserDefaults.standard.set(encoded, forKey: "calendar_access_status")
            }
        }
    }
    
    @Published var userSelectedCalendars = Set<EKCalendar>() {
        didSet {
            var calendarIDs = [String]()
            for calendar in userSelectedCalendars {
                calendarIDs.append(calendar.calendarIdentifier)
            }
            
            if let encoded = try? self.jsonEncoder.encode(calendarIDs) {
                UserDefaults.standard.set(encoded, forKey: "user_selected_calendars")
            }
        }
    }
    
    init() {
        self.ekstore = EKEventStore()
        
        if let saved_events = UserDefaults.standard.data(forKey: "saved_events") {
            if let decoded = try? self.jsonDecoder.decode([Event].self, from: saved_events) {
                self.savedEvents = decoded
            }
        }
        
        if let calendar_access_status = UserDefaults.standard.data(forKey: "calendar_access_status") {
            if let decoded = try? self.jsonDecoder.decode(Bool.self, from: calendar_access_status) {
                self.calendarAccessGranted = decoded
            }
        }
        
        if let user_selected_calendars = UserDefaults.standard.data(forKey: "user_selected_calendars") {
            if let decoded = try? self.jsonDecoder.decode([String].self, from: user_selected_calendars) {
                for id in decoded {
                    if let calendar = ekstore.calendar(withIdentifier: id) {
                        userSelectedCalendars.insert(calendar)
                    }
                }
            }
        }
        
        self.ekstore.requestAccess(to: .event) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    self.calendarAccessGranted = granted
                }
                print("Calendar Access Granted")
            } else {
                print("Calendar Access NOT Granted")
            }
        }
    }
}
