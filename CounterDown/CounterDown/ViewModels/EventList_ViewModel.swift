//
//  EventList_ViewModel.swift
//  CounterDown
//
//  Created by Cameron Slash on 23/7/22.
//

import CounterKit
import Foundation
import SlashKit
import SwiftUI

class EventListViewModel: ObservableObject {
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            ModelData.shared.now = Date()
        }
    }
}
