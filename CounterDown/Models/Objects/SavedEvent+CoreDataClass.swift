//
//  SavedEvent+CoreDataClass.swift
//  CounterDown
//
//  Created by Cameron Slash on 23/6/22.
//
//

import Foundation
import CoreData

@objc(SavedEvent)
public class SavedEvent: NSManagedObject {

}

extension SavedEvent {
    static func getSavedEventFetchRequest() -> NSFetchRequest<SavedEvent> {
        let request = SavedEvent.fetchRequest() as! NSFetchRequest<SavedEvent>
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(SavedEvent.due), ascending: true)]
        return request
    }
}
