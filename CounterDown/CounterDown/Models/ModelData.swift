//
//  ModelData.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import CoreData
import CounterKit
import EventKit
import Foundation
import SwiftUI

class ModelData: ObservableObject {
    static let shared = ModelData()
    let userdefaults = UserDefaults(suiteName: "group.Cameron.Slash.CounterDown")!
    let ekstore: EKEventStore
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    @Published var calendarAccessGranted = false {
        didSet {
            if let encoded = try? self.jsonEncoder.encode(calendarAccessGranted) {
                self.userdefaults.set(encoded, forKey: "calendar_access_status")
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
                self.userdefaults.set(encoded, forKey: "user_selected_calendars")
            }
        }
    }
    
    @Published var accentcolor = Color.primary {
        didSet {
            
            if let encoded = try? self.jsonEncoder.encode(accentcolor) {
                self.userdefaults.set(encoded, forKey: "user_selected_accentcolor")
            }
        }
    }
    
    init() {
        self.ekstore = EKEventStore()
        
        if let calendar_access_status = self.userdefaults.data(forKey: "calendar_access_status") {
            if let decoded = try? self.jsonDecoder.decode(Bool.self, from: calendar_access_status) {
                self.calendarAccessGranted = decoded
            }
        }
        
        if let user_selected_calendars = self.userdefaults.data(forKey: "user_selected_calendars") {
            if let decoded = try? self.jsonDecoder.decode([String].self, from: user_selected_calendars) {
                for id in decoded {
                    if let calendar = ekstore.calendar(withIdentifier: id) {
                        userSelectedCalendars.insert(calendar)
                    }
                }
            }
        }
        
        if let user_selected_accentcolor = self.userdefaults.data(forKey: "user_selected_accentcolor") {
            if let decoded = try? self.jsonDecoder.decode(Color.self, from: user_selected_accentcolor) {
                self.accentcolor = decoded
            }
        }
        
        self.ekstore.requestAccess(to: .event) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    self.calendarAccessGranted = granted
                }
            }
        }
    }
}
