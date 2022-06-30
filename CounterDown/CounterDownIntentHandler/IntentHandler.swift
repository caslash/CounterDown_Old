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
        let moc = DataController.shared.container.viewContext
        do {
            let savedevents = try moc.fetch(SavedEvent.getSavedEventFetchRequest())
            let events = savedevents.map { CountdownEvent(identifier: $0.wrappedEvent.id.uuidString, display: $0.wrappedEvent.name) }

            let collection = INObjectCollection(items: events)

            completion(collection, nil)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
    func defaultEvent(for intent: DynamicEventSelectionIntent) -> CountdownEvent? {
        return CountdownEvent(identifier: PreviewEvents.nyd.id.uuidString, display: PreviewEvents.nyd.name)
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
}
