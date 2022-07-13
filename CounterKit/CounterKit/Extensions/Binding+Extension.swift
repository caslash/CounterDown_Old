//
//  Binding+Extension.swift
//  UltimatePortfolio
//
//  Created by Cameron Slash on 09/7/22.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newVal in
                self.wrappedValue = newVal
                handler()
            }
        )
    }
}
