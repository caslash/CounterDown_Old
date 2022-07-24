//
//  ContentView.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import CounterKit
import CoreData
import SFSymbolsFinder
import SlashKit
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var modeldata: ModelData
    @ObservedObject var viewmodel = ContentViewModel()
    @State private var showingAddSheet = false
    @State private var showingSettingsSheet = false
    @State private var showingEditSheet = false
    var body: some View {
        NavigationView {
            EventListView(showingAddSheet: self.$showingAddSheet)
                .navigationTitle("Events")
                .sheet(isPresented: self.$showingAddSheet) {
                    if #available(iOS 16, *) {
                        AddEventView()
                            .presentationDetents([.fraction(0.5), .large])
                    } else {
                        AddEventView()
                    }
                }
                .sheet(isPresented: self.$showingSettingsSheet) {
                    if #available(iOS 16.0, *) {
                        SettingsView()
                            .presentationDetents([.fraction(0.3)])
                    } else {
                        SettingsView()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            self.showingAddSheet = true
                        } label: {
                            Label("Add Event", systemImage: "plus")
                                .font(.body.weight(.black))
                                .labelStyle(.iconOnly)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            self.showingSettingsSheet = true
                        } label: {
                            Label("Settings", systemImage: "gear")
                                .font(.body.weight(.black))
                                .labelStyle(.iconOnly)
                        }
                    }
                }
                .accentColor(self.modeldata.accentcolor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
            .environmentObject(ModelData.shared)
    }
}
