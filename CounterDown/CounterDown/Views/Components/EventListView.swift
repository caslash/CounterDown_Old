//
//  EventListView.swift
//  CounterDown
//
//  Created by Cameron Slash on 23/7/22.
//

import CounterKit
import SwiftUI

struct EventListView: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var modeldata: ModelData
    @FetchRequest(fetchRequest: SavedEvent.getSavedEventFetchRequest(), animation: Animation.spring()) var events: FetchedResults<SavedEvent>
    @ObservedObject var viewmodel = EventListViewModel()
    @Binding var showingAddSheet: Bool
    
    @ViewBuilder
    var body: some View {
        ScrollView(showsIndicators: false) {
            if !self.events.isEmpty {
                ForEach(self.events, id: \.id) { event in
                    if #available(iOS 16.0, *) {
                        GradientEventView(event: event)
                    } else {
                        FlatEventView(event: event)
                    }
                }
            } else {
                NewEventView(showingAddSheet: self.$showingAddSheet)
            }
        }
        .padding(.horizontal)
        .onAppear {
            _ = self.viewmodel.timer
        }
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(showingAddSheet: .constant(false))
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
            .environmentObject(DataController.preview)
            .environmentObject(ModelData.shared)
    }
}
