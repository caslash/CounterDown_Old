//
//  DataController.swift
//  CounterDown
//
//  Created by Cameron Slash on 23/6/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    static var shared = DataController()
    
    static let preview: DataController = {
        DataController()
    }()
    
    lazy var container: NSPersistentCloudKitContainer = {
       var container = NSPersistentCloudKitContainer(name: "CounterDownModel")
        
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No Descriptions Found")
        }
        description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.processUpdate), name: .NSPersistentStoreRemoteChange, object: nil)
        
        return container
    }()
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    @objc
    func processUpdate(notification: NSNotification) {
        operationQueue.addOperation {
            let context = self.container.newBackgroundContext()
            context.performAndWait {
                var events: [SavedEvent]
                do {
                    try events = context.fetch(SavedEvent.getSavedEventFetchRequest())
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
                
                events.sort {
                    $0.due! < $1.due!
                }
                
                if context.hasChanges {
                    do {
                        try context.save()
                    } catch {
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }
            }
        }
    }
    
    lazy var operationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}
