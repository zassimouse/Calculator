//
//  CalculatorControllerViewModel.swift
//  MyCalculator
//
//  Created by Denis Haritonenko on 13.06.24.
//

import Foundation

// Aarithmetic operations are performed on two operands.
// The enum state indicates which one of the operands is currently being inputted.
enum CurrentNumber {
    case firstNumber
    case secondNumber
}

class CalculatorControllerViewModel {
    
    var updateViews: (()->Void)?
    
    // MARK: - Collection View Data Source
    let calculatorButtonCells: [CalculatorButton] = [
        .clear, .plusMinus, .percentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .subtract,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
    ]
    
    // MARK: - Variables
    private(set) lazy var numberLabelText: String = self.firstNumber ?? "0"
    private(set) lazy var resultLabelText: String = "0"
    
    private(set) var currentNumber: CurrentNumber = .firstNumber
    
    private(set) var firstNumber: String? = nil { didSet { self.numberLabelText = self.firstNumber?.description ?? "0" } }
    private(set) var secondNumber: String? = nil { didSet { self.numberLabelText = self.secondNumber?.description ?? "0" } }
    
    private(set) var operation: CalculatorOperation? = nil
    
    private(set) var firstNumberIsDecimal: Bool = false
    private(set) var secondNumberIsDecimal: Bool = false
    
    // Remember previous number and operation
    // Example: 5 + 3 = 8 = 11 = 14 = 17 (Repeat the operation when the equals button is pressed)
    private(set) var previousNumber: String? = nil
    private(set) var previousOperation: CalculatorOperation? = nil
}



extension CalculatorControllerViewModel {
    
    public func didSelectButton(with calculatorButton: CalculatorButton) {
        switch calculatorButton {
            
        case .add:
            self.didSelectOperation(with: .add)
        case .subtract:
            self.didSelectOperation(with: .subtract)
        case .multiply:
            self.didSelectOperation(with: .multiply)
        case .divide:
            self.didSelectOperation(with: .divide)
        case .equals:
            self.didSelectEqualsButton()
        case .clear:
            didSelectClear()
        case .number(let value):
            self.didSelectNumber(with: value)
        case .decimal:
            self.didSelectDecimal()
        case .plusMinus:
            self.didSelectPlusMinus()
        case .percentage:
            self.didSelectPercentage()
        }
    
        self.updateViews?()
    }
    
    // MARK: - Clear
    private func didSelectClear() {
        self.numberLabelText = "0"
        self.resultLabelText = "0"
        self.currentNumber = .firstNumber
        self.firstNumber = nil
        self.secondNumber = nil
        self.operation = nil
        self.firstNumberIsDecimal = false
        self.secondNumberIsDecimal = false
        self.previousNumber = nil
        self.previousOperation = nil
    }
}

// MARK: - Numbers
extension CalculatorControllerViewModel {
    private func didSelectNumber(with number: Int) {
        
        if self.currentNumber == .firstNumber {
            if self.firstNumber == "0" {
                if number != 0 {
                    self.firstNumber = number.description
                }
                return
            }
            // If there are alredy digits in the number
            if self.firstNumber != nil {
                if var firstNumber = self.firstNumber, firstNumber.isValidNumberLength {
                    firstNumber.append(number.description)
                    self.firstNumber = firstNumber
                }
            // If there are no digits in the number yet
            } else {
                self.firstNumber = number.description
                self.previousNumber = number.description
            }
        } else {
            if self.secondNumber == "0" {
                if number != 0 {
                    self.secondNumber = number.description
                }
                return
            }
            if self.secondNumber != nil {
                if var secondNumber = self.secondNumber, secondNumber.isValidNumberLength {
                    secondNumber.append(number.description)
                    self.secondNumber = secondNumber
                    self.previousNumber = secondNumber
                }
            } else {
                self.secondNumber = number.description
                self.previousNumber = number.description
            }
        }
    }
    
}





// MARK: - Arithmetic Operations, Equals
extension CalculatorControllerViewModel {
    
    private func didSelectEqualsButton() {
         
        if let operation = self.operation,
           let firstNumber = self.firstNumber?.toDouble,
           let secondNumber = self.secondNumber?.toDouble {
            
            let result = self.getOperationResult(operation, firstNumber, secondNumber)
            // If either first or second number is decimal, display a decimal result
            let resultString = self.isDecimalResult(result) ? result.floatingPointToString : result.toInt?.description
            
            self.secondNumber = nil
            self.previousOperation = operation
            self.operation = nil
            self.firstNumber = resultString
            self.currentNumber = .firstNumber
            
            self.resultLabelText = resultString ?? "0"
            
        } else if let previousOperation = self.previousOperation,
                  let firstNumber = self.firstNumber?.toDouble,
                  let previousNumber = self.previousNumber?.toDouble {
            // Update based on previously selected number and arithmetic operation
            let result = self.getOperationResult(previousOperation, firstNumber, previousNumber)
            let resultString = self.isDecimalResult(result) ? result.floatingPointToString : result.toInt?.description


            self.firstNumber = resultString
            self.resultLabelText = resultString ?? "0"
        }
    }
    
    private func didSelectOperation(with operation: CalculatorOperation) {
        
        if self.currentNumber == .firstNumber {
            self.operation = operation
            self.currentNumber = .secondNumber
        } else if self.currentNumber == .secondNumber {
            
            if let previousOperation = self.operation,
               let firstNumber = self.firstNumber?.toDouble,
               let secondNumber = self.secondNumber?.toDouble {
                
                // Do previous opearion first
                let result = self.getOperationResult(previousOperation, firstNumber, secondNumber)
                let resultString = self.isDecimalResult(result) ? result.floatingPointToString : result.toInt?.description
                
                self.secondNumber = nil
                self.firstNumber = resultString
                self.currentNumber = .secondNumber
                self.operation = operation
                self.resultLabelText = resultString ?? "0"
            } else {
                // Another operator has been chosen
                self.operation = operation
            }
        }
    }
    

    private func getOperationResult(_ operation: CalculatorOperation, _ firstNumber: Double?, _ secondNumber: Double?) -> Double {
        guard let firstNumber = firstNumber, let secondNumber = secondNumber else { return 0 }
        
        let decimalFirstNumber = Decimal(firstNumber)
        let decimalSecondNumber = Decimal(secondNumber)
        var result: Decimal
        
        switch operation {
        case .add:
            result = decimalFirstNumber + decimalSecondNumber
        case .subtract:
            result = decimalFirstNumber - decimalSecondNumber
        case .multiply:
            result = decimalFirstNumber * decimalSecondNumber
            // Check for overflow for multiplication
            let maxDouble = Double.greatestFiniteMagnitude
            if result > Decimal(maxDouble) {
                return maxDouble
            } else if result < -Decimal(maxDouble) {
                return -maxDouble
            }
            
        case .divide:
            // Handle division by zero
            if decimalSecondNumber == 0 {
                return 0
            }
            
            result = decimalFirstNumber / decimalSecondNumber
            
            // Check for overflow for division
            let maxDouble = Double.greatestFiniteMagnitude
            if result > Decimal(maxDouble) {
                return maxDouble
            } else if result < -Decimal(maxDouble) {
                return -maxDouble
            }
        }
        
        // Convert Decimal result to Double
        return NSDecimalNumber(decimal: result).doubleValue
    }


    // Determine if the result will be output in integer or decimal format.
    // Example: 3.0 + 4 = 7 not 7.0
    // Example 10 / 3 = 3.33333 not 3
    private func isDecimalResult(_ result: Double) -> Bool {
        
        if operation == .divide, !result.isInteger {
            return true
        }
        
        if let firstNumber = self.firstNumber?.toDouble {
            if firstNumber.isInteger {
                self.firstNumberIsDecimal = false
                self.firstNumber = firstNumber.toInt?.description
            }
        }
        if let secondNumber = self.secondNumber?.toDouble {
            if secondNumber.isInteger {
                self.secondNumberIsDecimal = false
                self.secondNumber = secondNumber.toInt?.description
            }
        }
        return firstNumberIsDecimal || secondNumberIsDecimal
    }
    
//    func doubleToScientificString(_ number: Double) -> String {
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .scientific
//        numberFormatter.maximumSignificantDigits = 9
//        numberFormatter.usesSignificantDigits = true
//        numberFormatter.decimalSeparator = "."
//
//        if let formattedString = numberFormatter.string(from: NSNumber(value: number)) {
//            return formattedString
//        } else {
//            return "Error"
//        }
//    }
}



// MARK: - Negatig, Percentage, Decimal
extension CalculatorControllerViewModel {
    
    private func didSelectPlusMinus() {
        
        if self.currentNumber == .firstNumber, var number = self.firstNumber {
            if number.contains("-") {
                number.removeFirst()
            } else {
                number.insert("-", at: number.startIndex)
            }
            self.firstNumber = number
            self.previousNumber = number
        } else if self.currentNumber == .secondNumber, var number = self.secondNumber {
            if number.contains("-") {
                number.removeFirst()
            } else {
                number.insert("-", at: number.startIndex)
            }
            self.secondNumber = number
            self.previousNumber = number
        }
    }
    
    private func didSelectPercentage() {
        
        if self.currentNumber == .firstNumber, var number = self.firstNumber?.toDouble {
            number /= 100
            if number.isInteger {
                self.firstNumber = number.toInt?.description
            } else {
                self.firstNumber = number.floatingPointToString
                self.firstNumberIsDecimal = true
            }
        } else if self.currentNumber == .secondNumber, var number = self.secondNumber?.toDouble {
            number /= 100
            if number.isInteger {
                self.secondNumber = number.toInt?.description
            } else {
                self.secondNumber = number.floatingPointToString
                self.secondNumberIsDecimal = true
            }
        }
    }
    
    private func didSelectDecimal() {
        
        if self.currentNumber == .firstNumber {
            self.firstNumberIsDecimal = true
            
            if let firstNumber = self.firstNumber, !firstNumber.contains(".") {
                self.firstNumber = firstNumber.appending(".")
            } else if self.firstNumber == nil {
                self.firstNumber = "0."
            }
            
        } else if self.currentNumber == .secondNumber {
            self.firstNumberIsDecimal = true
            
            if let secondNumber = self.secondNumber, !secondNumber.contains(".") {
                self.secondNumber = secondNumber.appending(".")
            } else if self.secondNumber == nil {
                self.secondNumber = "0."
            }
        }
    }
}
