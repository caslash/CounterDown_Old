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
    @EnvironmentObject var modeldata: ModelData
    @StateObject var viewmodel: EditEventViewModel
    var body: some View {
        NavigationView {
            Form {
                TextField("Event Name", text: $viewmodel.name)
                
                DatePicker("Event Date", selection: $viewmodel.due)
                
                ColorPicker("Event Color", selection: $viewmodel.color)
                
                Toggle("Show Years", isOn: $viewmodel.includeYear)
                
                Toggle("Show Months", isOn: $viewmodel.includeMonth)
            }
            .navigationTitle("Edit Event")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        self.viewmodel.editEvent()
                        self.modeldata.saveMoc()
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
            .accentColor(modeldata.accentcolor)
        }
    }
    
    init(_ event: Event) {
        _viewmodel = StateObject(wrappedValue: EditEventViewModel(event))
    }
}

struct EditEventView_Previews: PreviewProvider {
    static var previews: some View {
        EditEventView(PreviewEvents.nyd)
    }
}
