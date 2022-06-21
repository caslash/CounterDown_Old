//
//  IntentHandler.swift
//  CounterDownIntentHandler
//
//  Created by Cameron Slash on 20/6/22.
//

import Intents

class IntentHandler: INExtension, DynamicEventSelectionIntentHandling {
    let userdefaults = UserDefaults(suiteName: "group.Cameron.Slash.CounterDown")!
    
    func provideEventOptionsCollection(for intent: DynamicEventSelectionIntent, with completion: @escaping (INObjectCollection<CountdownEvent>?, Error?) -> Void) {
        if let saved_events = self.userdefaults.data(forKey: "saved_events") {
            if let decoded = try? JSONDecoder().decode([Event].self, from: saved_events) {
                let events = decoded.map { event in
                    return CountdownEvent(identifier: event.id.uuidString, display: event.name)
                }
                
                let collection = INObjectCollection(items: events)
                
                completion(collection, nil)
            }
        }
    }
    
    func defaultEvent(for intent: DynamicEventSelectionIntent) -> CountdownEvent? {
        return CountdownEvent(identifier: PreviewEvents.nyd.id.uuidString, display: PreviewEvents.nyd.name)
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
}
