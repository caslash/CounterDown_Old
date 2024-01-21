//
//  SavedEventSnapshot.swift
//  CounterKit
//
//  Created by Cameron Slash on 1/17/24.
//

import Foundation

public struct SavedEventSnapshot {
    public var event: SavedEvent
    public var timeInterval: TimeInterval
    public var date: Date
    
    public init(event: SavedEvent, timeInterval: TimeInterval, date: Date) {
        self.event = event
        self.timeInterval = timeInterval
        self.date = date
    }
    
    public func merged(with other: SavedEventSnapshot, maxDistance: TimeInterval = TimeInterval(minutes: 5)) -> SavedEventSnapshot? {
        guard date.distance(to: other.date) < maxDistance else {
            return nil
        }
        
        let moreRecent = self.date > other.date ? self : other
        
        return SavedEventSnapshot(
            event: self.event,
            timeInterval: moreRecent.timeInterval,
            date: moreRecent.date
        )
    }
}
