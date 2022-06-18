//
//  Event.swift
//  Countdown
//
//  Created by Cameron Slash on 26/5/22.
//

import Foundation
import SwiftUI

struct Event: Codable, Identifiable {
    var id = UUID()
    var name: String
    var due: Date
    var color: Color
    var components: Set<Calendar.Component>
}
