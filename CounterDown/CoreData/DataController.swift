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
    
    let container: NSPersistentContainer = {
       var container = NSPersistentContainer(name: "CounterDownModel")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
        
        return container
    }()
}
