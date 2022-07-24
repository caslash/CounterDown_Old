//
//  AddEventView.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import CounterKit
import SFSymbolsFinder
import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var modeldata: ModelData
    @StateObject var viewmodel = AddEventViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Create New Event")) {
                    TextField("Event Name", text: self.$viewmodel.name)
                    
                    DatePicker("Event Date", selection: self.$viewmodel.due)
                    
                    ColorPicker("Event Color", selection: self.$viewmodel.color)
                    
                    Toggle("Show Years", isOn: self.$viewmodel.includeYear)
                    
                    Toggle("Show Months", isOn: self.$viewmodel.includeMonth)
                    
                    Toggle("Is This Event Recurring", isOn: self.$viewmodel.isRecurring)
                    
                    if self.viewmodel.isRecurring {
                        Picker("Repeat", selection: self.$viewmodel.recurrenceInterval) {
                            ForEach(RecurrenceInterval.allCases.dropFirst(), id: \.self) { interval in
                                Text(interval.displayName)
                            }
                        }
                    }
                }
                
                if !self.viewmodel.calendarEvents.isEmpty {
                    Section(header: Text("Select Event From Calendar")) {
                        ForEach(self.viewmodel.calendarEvents, id: \.self) { event in
                            Button {
                                self.viewmodel.name = event.title
                                self.viewmodel.due = event.startDate
                            } label: {
                                HStack {
                                    if self.viewmodel.name == event.title && self.viewmodel.due == event.startDate {
                                        Image(systemName: .checkmarkCircleFill)
                                    } else {
                                        Image(systemName: .circle)
                                    }
                                    
                                    Text(event.title)
                                }
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Add Event")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        self.viewmodel.addEvent()
                        self.dataController.save()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: .plus)
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: .xmarkCircleFill)
                    }
                }
            }
            .accentColor(self.modeldata.accentcolor)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
            .environmentObject(DataController.preview)
            .environmentObject(ModelData.shared)
    }
}
