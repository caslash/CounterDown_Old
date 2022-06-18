//
//  ContentView.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import SFSymbolsFinder
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modeldata: ModelData
    @ObservedObject var viewmodel = ContentViewModel()
    @State var eventToEdit: Event?
    @State private var showingAddSheet = false
    @State private var showingSettingsSheet = false
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(modeldata.savedEvents, id: \.id) { event in
                        EventView(event: event, now: self.viewmodel.now)
                            .contextMenu {
                                if #available(iOS 15.0, *) {
                                    Button(role: .cancel) {
                                        self.eventToEdit = event
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    Button(role: .destructive) { modeldata.savedEvents.removeAll(where: { $0.id == event.id }) } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                } else {
                                    Button {
                                        modeldata.savedEvents.removeAll(where: { $0.id == event.id })
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                    }
                }
                .padding()
            }
            .onAppear {
                _ = self.viewmodel.timer
            }
            .navigationTitle("Events")
            .sheet(isPresented: $showingAddSheet) {
                if #available(iOS 16, *) {
                    AddEventView()
                        .presentationDetents([.fraction(0.42), .large])
                } else {
                    AddEventView()
                }
            }
            .sheet(item: $eventToEdit) { event in
                if #available(iOS 16.0, *) {
                    EditEventView(event)
                        .presentationDetents([.fraction(0.42)])
                } else {
                    EditEventView(event)
                }
            }
            .sheet(isPresented: $showingSettingsSheet) {
                if #available(iOS 16.0, *) {
                    SettingsView()
                        .presentationDetents([.medium, .large])
                } else {
                    SettingsView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: .plus)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSettingsSheet = true
                    } label: {
                        Image(systemName: .gear)
                    }
                }
            }
            .accentColor(modeldata.accentcolor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData.shared)
    }
}
