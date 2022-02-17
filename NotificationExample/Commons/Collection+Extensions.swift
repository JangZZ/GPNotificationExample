//
//  Collection+Extensions.swift
//  NotificationExample
//
//  Created by TruongGiang on 16/02/2022.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
