//
//  Content_ViewModel.swift
//  Countdown
//
//  Created by Cameron Slash on 27/5/22.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var now = Date()
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.now = Date()
        }
    }
}
