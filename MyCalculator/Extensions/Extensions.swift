//
//  Extensions.swift
//  MyCalculator
//
//  Created by Denis Haritonenko on 13.06.24.
//

import Foundation

extension Double {
    var toInt: Int? {
        return Int(self)
    }
    
    // A dot separator is required, no grouping separators
    // The maximum number of digits allowed is 9
    var floatingPointToString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumSignificantDigits = 9
        numberFormatter.usesSignificantDigits = true
        numberFormatter.numberStyle = .decimal
        numberFormatter.decimalSeparator = "."
        numberFormatter.usesGroupingSeparator = false

        if let formattedString = numberFormatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            return "Error"
        }
    }
    
    var withoutFloatingPointToString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumSignificantDigits = 9
        numberFormatter.usesSignificantDigits = true
        numberFormatter.numberStyle = .decimal
        numberFormatter.decimalSeparator = "."
        numberFormatter.usesGroupingSeparator = false

        if let formattedString = numberFormatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            return "Error"
        }
    }
}

extension String {
    var toDouble: Double? {
        return Double(self)
    }
    
    var isValidNumberLength: Bool {
        let digitCount = self.filter { "0123456789".contains($0) }.count
        if digitCount < 9 {
            return true
        }
        return false
    }
}

extension FloatingPoint {
    var isInteger: Bool { return rounded() == self }
}
