//
//  State.swift
//  ApexApp
//
//  Created by Timothy Hang on 8/21/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import Foundation
import Apex

struct CurrentState: State {
  var operandOne = "0"
  var operandTwo = "0"
  var operatorSymbol = ""
  var result = "0"
  
  mutating func transition(_ action: Action)
  {
    var result = Double(self.result) ?? 0
    
    switch action {
    case Actions.operandTapped(let numberString):
      if operatorSymbol == "" {
        operandOne += numberString
        result = Double(operandOne) ?? 0
      } else {
        operandTwo += numberString
        result = Double(operandTwo) ?? 0
      }
    case Actions.operatorTapped(let operatorOption):
      switch operatorOption {
      case .add, .subtract, .multiply, .divide:
        operatorSymbol = operatorOption.rawValue
      case .plusMinus:
        result *= -1
      case .squareRoot:
        result = sqrt(result)
      case .clear:
        result = 0
      case .percent:
        result *= 100
      case .equals:
        var operandOne = Double(self.operandOne) ?? 0
        var operandTwo = Double(self.operandTwo) ?? 0
      
        switch operatorSymbol {
        case "+": result = operandOne + operandTwo
        case "-": result = operandOne - operandTwo
        case "*": result = operandOne * operandTwo
        case "/":
          if operandTwo == 0 {
            defer { self.result = "Cannot / by 0" }
          } else {
            result = operandOne / operandTwo
          }
        default: break
        }
      }
    default: break
    }
    
    self.result = String(result)
    self.operandOne = String(result)
    self.operandTwo = "0"
    result = 0
  }
}
