//
//  Sequence+Extension.swift
//  UltimatePortfolio
//
//  Created by Cameron Slash on 10/7/22.
//

import Foundation

extension Sequence {
    func sorted<Value>(by keyPath: KeyPath<Element, Value>, using areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
        try self.sorted {
            try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
    
    func sorted<Value: Comparable>(sortedBy keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted(by: keyPath, using: <)
    }
    
    func sorted(by sortDescriptor: NSSortDescriptor) -> [Element] {
        self.sorted { sortDescriptor.compare($0, to: $1) == .orderedAscending }
    }
}
