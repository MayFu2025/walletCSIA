//
//  Item.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
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
