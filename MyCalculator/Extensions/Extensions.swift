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
}

extension String {
    var toDouble: Double? {
        return Double(self)
    }
}

extension FloatingPoint {
    var isInteger: Bool { return rounded() == self}
}
