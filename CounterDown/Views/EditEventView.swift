//
//  EditEventView.swift
//  Countdown
//
//  Created by Cameron Slash on 17/6/22.
//

import SwiftUI

struct EditEventView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var modeldata: ModelData
    @ObservedObject var viewmodel: EditEventViewModel
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
                        viewmodel.editEvent()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: .xmarkCircleFill)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    init(_ event: Event) {
        self.viewmodel = EditEventViewModel(event)
    }
}

struct EditEventView_Previews: PreviewProvider {
    static var previews: some View {
        EditEventView(ModelData.shared.savedEvents.first!)
    }
}
