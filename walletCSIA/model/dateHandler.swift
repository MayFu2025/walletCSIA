//
//  dateHandler.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/24.
//

import Foundation
import SwiftData

class DateHandler {
    var calendar: Calendar
    var currentDate: Date
    var dateFormatter: DateFormatter
    
    init(calendar: Calendar = Calendar.current, currentDate: Date = Date()) {
            self.calendar = calendar
            self.currentDate = currentDate
            self.dateFormatter = DateFormatter()
            self.dateFormatter.calendar = calendar
    }
    
    func currentYearDateRange() -> (start: Date, end: Date)? {
        // Get the start of the month
        guard let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: currentDate)) else {
            return nil
        }
        // Get the end of the month by adding one month and subtracting a second
        guard let endOfYear = calendar.date(byAdding: .year, value: 1, to: startOfYear)?.addingTimeInterval(-1) else {
            return nil
        }
        return (start: startOfYear, end: endOfYear)
    }
    
    func currentMonthDateRange() -> (start: Date, end: Date)? {
        // Get the start of the month
        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate)) else {
            return nil
        }
        // Get the end of the month
        guard let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)?.addingTimeInterval(-1) else {
            return nil
        }
        return (start: startOfMonth, end: endOfMonth)
    }
    
    func customDateRange(startDate: Date, endDate: Date = Date()) -> (start: Date, end: Date)? {
        // Ensure the start date is normalized to the start of the day (midnight)
        guard let startOfRange = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: startDate)) else {
            return nil
        }
        // Get the end date, but set it to the end of the day (23:59:59)
        guard let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: endDate) else {
            return nil
        }
        // Ensure the start date is before or equal to the end date
        if startOfRange > endOfDay {
            return nil
        }
        return (start: startOfRange, end: endOfDay)
    }
}
