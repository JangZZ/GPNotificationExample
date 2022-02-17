//
//  Array+Extensions.swift
//  NotificationExample
//
//  Created by TruongGiang on 16/02/2022.
//

import Foundation

var isRunningTests: Bool {
    return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}

extension Array where Element == GPNotification {

    mutating func read(at indexPath: IndexPath) {
        if !isRunningTests {
            precondition(indices.contains(indexPath.row), "Out of index 😭")
        }
        modifyElement(atIndex: indexPath.row) { $0.read() }
    }
}

extension Array {
    mutating func modifyForEach(_ body: (_ index: Index, _ element: inout Element) -> ()) {
        for index in indices {
            modifyElement(atIndex: index) { body(index, &$0) }
        }
    }

    mutating func modifyElement(atIndex index: Index, _ modifyElement: (_ element: inout Element) -> ()) {
        if var element = self[safe: index] {
            modifyElement(&element)
            self[index] = element
        }
    }
}
