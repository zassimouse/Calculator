//
//  CalculatorControllerViewModel.swift
//  MyCalculator
//
//  Created by Denis Haritonenko on 13.06.24.
//

import Foundation

enum CurrentNumber {
    case firstNumber
    case secondNumber
}

class CalculatorControllerViewModel {
    
    var updateViews: (()->Void)?
    
    let calculatorButtonCells: [CalculatorButton] = [
        .clear, .plusMinus, .percentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .substract,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
    ]
    
    private(set) lazy var calcHeaderLabel: String = (self.firstNumber ?? 0).description
    private(set) lazy var currentNumber: CurrentNumber = .firstNumber
    
    private(set) lazy var firstNumber: Int? = nil { didSet { self.calcHeaderLabel = self.firstNumber?.description ?? "0" } }
    private(set) lazy var secondNumber: Int? = nil { didSet { self.calcHeaderLabel = self.secondNumber?.description ?? "0" } }
    
    private(set) var previousNumber: Int? = nil
    
}

extension CalculatorControllerViewModel {
    
    public func didSelectButton(with calculatorButton: CalculatorButton) {
        switch calculatorButton {
            
        case .add:
            fatalError("Not Impl")
        case .substract:
            fatalError("Not Impl")
        case .multiply:
            fatalError("Not Impl")
        case .divide:
            fatalError("Not Impl")
        case .equals:
            fatalError("Not Impl")
        case .clear:
            fatalError("Not Impl")
        case .number(let number):
            self.didSelectNumber(with: number)
        case .decimal:
            fatalError("Not Impl")
        case .plusMinus:
            fatalError("Not Impl")
        case .percentage:
            fatalError("Not Impl")
        }
        
        self.updateViews?()
    }
}


extension CalculatorControllerViewModel {
    private func didSelectNumber(with number: Int) {
        
        if self.currentNumber == .firstNumber {
            // If there are already digits in the number
            if let firstNumber = self.firstNumber {
                // Concatenate the digit
                var firstNumberString = firstNumber.description
                firstNumberString.append(number.description)
                // Save the number
                self.firstNumber = Int(firstNumberString)
                self.previousNumber = Int(firstNumberString)
            // If there are no digits in the number
            } else {
                // The number is a digit
                self.firstNumber = Int(number)
                self.previousNumber = Int(number)
            }
            
        } else {
            if let secondNumber = self.secondNumber {
                var secondNumberString = secondNumber.description
                secondNumberString.append(number.description)
                self.secondNumber = Int(secondNumberString)
                self.previousNumber = Int(secondNumber)
            } else {
                self.secondNumber = Int(number)
                self.previousNumber = Int(number)
            }
        }
        
        
    }
}
