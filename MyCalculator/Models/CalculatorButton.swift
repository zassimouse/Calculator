//
//  CalculatorButton.swift
//  MyCalculator
//
//  Created by Denis Haritonenko on 13.06.24.
//

import Foundation
import UIKit

enum CalculatorButton {
    
    case add
    case substract
    case multiply
    case divide
    
    case equals
    case clear
    
    case number(Int)
    case decimal
    case plusMinus
    case percentage
    
    init(calculatorButton: CalculatorButton) {
        switch calculatorButton {
            
        case .divide, .multiply, .substract, .add, .equals, .decimal, .clear, .plusMinus, .percentage:
            self = calculatorButton
        case .number(let int):
            if int.description.count == 1 {
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
        case .substract:
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
    
    var color: UIColor {
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
        case .add, .substract, .multiply, .divide, .percentage:
            return .calculatorGreen
        default:
            return .white
        }
    }
    
    
}
 
