//
//  Extension+Date.swift
//  iSteps
//
//  Created by Данил Белов on 04.07.2023.
//

import Foundation

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
    
    static func dateFormatter(string: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = string
        return formatter
    }
}
