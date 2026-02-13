//
//  Item.swift
//  DM6-TP3-CoreData
//
//  Created by Xavier Giguerre on 2026-02-12.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
