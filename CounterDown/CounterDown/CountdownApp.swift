//
//  CountdownApp.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import CounterKit
import SwiftUI

@main
struct CountdownApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, DataController.shared.container.viewContext)
                .environmentObject(DataController.shared)
                .environmentObject(ModelData.shared)
        }
    }
}
