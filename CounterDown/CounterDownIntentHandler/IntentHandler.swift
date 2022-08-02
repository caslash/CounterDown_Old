//
//  IntentHandler.swift
//  CounterDownIntentHandler
//
//  Created by Cameron Slash on 20/6/22.
//

import CounterKit
import Intents

class IntentHandler: INExtension, DynamicEventSelectionIntentHandling {
    
    func provideEventOptionsCollection(for intent: DynamicEventSelectionIntent, with completion: @escaping (INObjectCollection<CountdownEvent>?, Error?) -> Void) {
        guard let savedevents = try? DataController.shared.container.viewContext.fetch(SavedEvent.getSavedEventFetchRequest()) else { return }
        let events = savedevents.map { CountdownEvent(identifier: $0.eventId.uuidString, display: $0.eventName) }

        let collection = INObjectCollection(items: events)

        completion(collection, nil)
        
    }
    
    func defaultEvent(for intent: DynamicEventSelectionIntent) -> CountdownEvent? {
        return CountdownEvent(identifier: SavedEvent.defaultEvent.eventId.uuidString, display: SavedEvent.defaultEvent.eventName)
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
}
