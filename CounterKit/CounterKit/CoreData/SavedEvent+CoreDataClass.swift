//
//  SavedEvent+CoreDataClass.swift
//  CounterKit
//
//  Created by Cameron Slash on 28/6/22.
//
//

import Foundation
import CoreData

@objc(SavedEvent)
public class SavedEvent: NSManagedObject {

}

extension SavedEvent {
    public static func getSavedEventFetchRequest() -> NSFetchRequest<SavedEvent> {
        let request = SavedEvent.fetchRequest() 
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(SavedEvent.due), ascending: true)]
        return request
    }
}
