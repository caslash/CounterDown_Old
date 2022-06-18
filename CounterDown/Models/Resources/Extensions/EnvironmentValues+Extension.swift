//
//  EnvironmentValues+Extension.swift
//  Countdown
//
//  Created by Cameron Slash on 30/5/22.
//

import Foundation
import SwiftUI

struct PresentationKey: EnvironmentKey {
    static let defaultValue: [Binding<Bool>] = []
}

extension EnvironmentValues {
    var presentations: [Binding<Bool>] {
        get { return self[PresentationKey.self] }
        set { self[PresentationKey.self] = newValue }
    }
}
