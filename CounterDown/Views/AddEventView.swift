//
//  AddEventView.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import SFSymbolsFinder
import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var modeldata: ModelData
    @ObservedObject var viewmodel = AddEventViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Create New Event")) {
                    TextField("Event Name", text: $viewmodel.name)
                    
                    DatePicker("Event Date", selection: $viewmodel.due)
                    
                    ColorPicker("Event Color", selection: $viewmodel.color)
                    
                    Toggle("Show Years", isOn: $viewmodel.includeYear)
                    
                    Toggle("Show Months", isOn: $viewmodel.includeMonth)
                }
                
                Section(header: Text("Select Event From Calendar")) {
                    ForEach(viewmodel.calendarEvents, id: \.eventIdentifier) { event in
                        Button {
                            viewmodel.name = event.title
                            viewmodel.due = event.startDate
                        } label: {
                            Text(event.title)
                        }
                    }
                }
                
            }
            .navigationTitle("Add Event")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        viewmodel.addEvent()
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
            .accentColor(modeldata.accentcolor)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
            .environmentObject(ModelData.shared)
    }
}
