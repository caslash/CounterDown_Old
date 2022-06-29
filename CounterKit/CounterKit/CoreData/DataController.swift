//
//  DataController.swift
//  CounterKit
//
//  Created by Cameron Slash on 27/6/22.
//

import CoreData
import Foundation

public class DataController: ObservableObject {
    public static var shared = DataController()
    
    static let preview: DataController = {
        DataController()
    }()
    
    public lazy var container: NSPersistentCloudKitContainer = {
        let momdName = "CounterDownModel"
        
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: momdName, withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        var container = NSPersistentCloudKitContainer(name: "CounterDownModel", managedObjectModel: mom)
        
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No Descriptions Found")
        }
        description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.Cameron.Slash.CounterDown")
        
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
    
    public func saveContext() {
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

