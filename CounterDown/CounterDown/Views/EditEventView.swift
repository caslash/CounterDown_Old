//
//  EditEventView.swift
//  Countdown
//
//  Created by Cameron Slash on 17/6/22.
//

import CounterKit
import CoreData
import SwiftUI

struct EditEventView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var modeldata: ModelData
    @StateObject var viewmodel: EditEventViewModel
    var body: some View {
        NavigationView {
            Form {
                TextField("Event Name", text: self.$viewmodel.name)
                
                DatePicker("Event Date", selection: self.$viewmodel.due)
                
                ColorPicker("Event Color", selection: self.$viewmodel.color)
                
                Toggle("Show Years", isOn: self.$viewmodel.includeYear)
                
                Toggle("Show Months", isOn: self.$viewmodel.includeMonth)
                
                Toggle("Is This Event Recurring?", isOn: self.$viewmodel.isRecurring)
                
                if self.viewmodel.isRecurring {
                    Picker("Repeat", selection: self.$viewmodel.recurrenceInterval) {
                        ForEach(RecurrenceInterval.allCases.dropFirst(), id: \.self) { interval in
                            Text("\(interval.displayName)")
                        }
                    }
                }
            }
            .navigationTitle("Edit Event")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        self.viewmodel.updateEvent()
                        self.dataController.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: .xmarkCircleFill)
                            .foregroundColor(.gray)
                    }
                }
            }
            .accentColor(self.modeldata.accentcolor)
        }
    }
    
    init(_ event: SavedEvent) {
        _viewmodel = StateObject(wrappedValue: EditEventViewModel(event))
    }
}

struct EditEventView_Previews: PreviewProvider {
    static var previews: some View {
        EditEventView(SavedEvent.exampleEvent)
            .environmentObject(DataController.preview)
            .environmentObject(ModelData.shared)
    }
}
