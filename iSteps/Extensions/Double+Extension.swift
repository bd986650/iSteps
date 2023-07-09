//
//  Double+Extension.swift
//  iSteps
//
//  Created by Данил Белов on 06.07.2023.
//

import Foundation

extension Double {
    func formatNumberWithFixedFraction(maximumFraction: Int = 8) -> String {
        let stringFloatNumber = String(format: "%.\(maximumFraction)f", self)
        return stringFloatNumber
    }
    
    func formatNumber(maximumFraction: Int = 8) -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = maximumFraction
        formatter.numberStyle = .decimal
        formatter.allowsFloats = true
        let formattedNumber = formatter.string(from: number)!
        return formattedNumber
    }
}
