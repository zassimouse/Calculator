//
//  CalculatorOperation.swift
//  MyCalculator
//
//  Created by Denis Haritonenko on 13.06.24.
//

import Foundation

enum CalculatorOperation {
    
    case add
    case subtract
    case multiply
    case divide
    
    var title: String {
        switch self {
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .multiply:
            return "×"
        case .divide:
            return "÷"
        }
    }
}
