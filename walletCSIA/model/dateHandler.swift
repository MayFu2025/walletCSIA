//
//  dateHandler.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/24.
//

import Foundation

extension Date {
    func monthName() -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("MMMM")
            return df.string(from: self)
    }
    
    func yearValue() -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("YYYY")
            return df.string(from: self)
    }
    
    func dashSeparated() -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
            return df.string(from: self)
    }
}
