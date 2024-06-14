//
//  CalculatorButton.swift
//  MyCalculator
//
//  Created by Denis Haritonenko on 13.06.24.
//

import Foundation
import UIKit

enum CalculatorButton {
    
    case clear
    case number(Int)
    case add
    case subtract
    case multiply
    case divide
    case equals
    case decimal
    case plusMinus
    case percentage
    
    init(calculatorButton: CalculatorButton) {
        
        switch calculatorButton {
        case .divide, .multiply, .subtract, .add, .equals, .decimal, .clear, .plusMinus, .percentage:
            self = calculatorButton
        case .number(let value):
            if value.description.count == 1 {
                self = calculatorButton
            } else {
                fatalError("Int is not 1 digit")
            }
        }
    }
}

extension CalculatorButton {
    
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
        case .equals:
            return "="
        case .clear:
            return "C"
        case .number(let value):
            return value.description
        case .decimal:
            return "."
        case .plusMinus:
            return "+/-"
        case .percentage:
            return "%"
        }
    }
    
    var backgroundColor: UIColor {
        
        switch self {
        case .clear:
            return .calculatorRed
        case .equals:
            return .calculatorGreen
        default:
            return .calculatorGrey
        }
    }
    
    var textColor: UIColor {
        
        switch self {
        case .clear, .equals:
            return .calculatorGrey
        case .add, .subtract, .multiply, .divide, .percentage:
            return .calculatorGreen
        default:
            return .white
        }
    }
}
 
