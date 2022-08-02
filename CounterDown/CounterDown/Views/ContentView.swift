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
    var body: some View {
        NavigationView {
            EventListView(showingAddSheet: self.$viewmodel.showingAddSheet)
                .navigationTitle("Events")
                .sheet(isPresented: self.$viewmodel.showingAddSheet) {
                    if #available(iOS 16, *) {
                        AddEventView()
                            .presentationDetents([.fraction(0.5), .large])
                    } else {
                        AddEventView()
                    }
                }
                .sheet(isPresented: self.$viewmodel.showingSettingsSheet) {
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
                            self.viewmodel.showingAddSheet = true
                        } label: {
                            Label("Add Event", systemImage: "plus")
                                .font(.body.weight(.black))
                                .labelStyle(.iconOnly)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            self.viewmodel.showingSettingsSheet = true
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
