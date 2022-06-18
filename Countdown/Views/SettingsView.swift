//
//  SettingsView.swift
//  Countdown
//
//  Created by Cameron Slash on 31/5/22.
//

import SFSymbolsFinder
import SwiftUI
import EventKit

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var modeldata: ModelData
    @State private var showingCalendarChooser = false
    @State private var showingInfo = false
    var buildNum: String {
        if let text = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return text
        }
        return "0"
    }
    
    var versionNum: String {
        if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return text
        }
        return "0"
    }
    var body: some View {
        NavigationView {
            Form {
                Button {
                    showingCalendarChooser = true
                } label: {
                    HStack {
                        Text("Choose Calendars")
                        
                        Spacer()
                        
                        Image(systemName: .chevronRight)
                    }
                }
                .foregroundColor(.primary)
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: .xmarkCircleFill)
                            .foregroundColor(.gray)
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        
                    } label: {
                        Image(systemName: .infoCircleFill)
                            .foregroundColor(.gray)
                    }
                }
            }
            .sheet(isPresented: $showingCalendarChooser) {
                    CalendarChooser(calendars: $modeldata.userSelectedCalendars, eventStore: ModelData.shared.ekstore)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $showingInfo) {
                Text("v\(versionNum) build \(buildNum)")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ModelData.shared)
    }
}
