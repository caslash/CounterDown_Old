//
//  CountdownApp.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import SwiftUI

@main
struct CountdownApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ModelData.shared)
                .environment(\.managedObjectContext, DataController.shared.container.viewContext)
        }
    }
}
