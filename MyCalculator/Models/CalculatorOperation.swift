//
//  CalculatorOperation.swift
//  MyCalculator
//
//  Created by Denis Haritonenko on 13.06.24.
//

import Foundation

enum CalculatorOperation {
    
    case add
    case substract
    case multiply
    case divide
    
    var title: String {
        switch self {
            
        case .add:
            return "+"
        case .substract:
            return "-"
        case .multiply:
            return "×"
        case .divide:
            return "÷"
        }
    }
}
