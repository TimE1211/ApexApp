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
  var operandOne = ""
  var operandTwo = ""
  var operatorSymbol = ""
  var result = ""
  
  mutating func transition(_ action: Action)
  {
    guard var result = Double(self.result) else { return }
    
    switch action {
    case Actions.operandTapped(let numberString):
      if operatorSymbol == "" {
        operandOne += numberString
      } else {
        operandTwo += numberString
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
        guard let operandOne = Double(self.operandOne),
          let operandTwo = Double(self.operandTwo) else {
            fatalError()
        }
        
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
  }
}
