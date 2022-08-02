//
//  Content_ViewModel.swift
//  Countdown
//
//  Created by Cameron Slash on 27/5/22.
//

import CounterKit
import Foundation

class ContentViewModel: ObservableObject {
    @Published var showingAddSheet = false
    @Published var showingSettingsSheet = false
}
