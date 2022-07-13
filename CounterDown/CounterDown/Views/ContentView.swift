//
//  ContentView.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import CounterKit
import CoreData
import SFSymbolsFinder
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var modeldata: ModelData
    @ObservedObject var viewmodel = ContentViewModel()
    @FetchRequest(fetchRequest: SavedEvent.getSavedEventFetchRequest()) var events: FetchedResults<SavedEvent>
    @State var eventToEdit: SavedEvent?
    @State private var showingAddSheet = false
    @State private var showingSettingsSheet = false
    @State private var showingEditSheet = false
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(self.events, id: \.id) { event in
                        if #available(iOS 16.0, *) {
                            GradientEventView(event: event)
                        } else {
                            FlatEventView(event: event)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                _ = self.viewmodel.timer
            }
            .navigationTitle("Events")
            .sheet(isPresented: self.$showingAddSheet) {
                if #available(iOS 16, *) {
                    AddEventView()
                        .presentationDetents([.fraction(0.5), .large])
                } else {
                    AddEventView()
                }
            }
            .sheet(item: self.$eventToEdit) { event in
                if #available(iOS 16.0, *) {
                    EditEventView(event)
                        .presentationDetents([.fraction(0.42)])
                } else {
                    EditEventView(event)
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
                        Image(systemName: .plus)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.showingSettingsSheet = true
                    } label: {
                        Image(systemName: .gear)
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
