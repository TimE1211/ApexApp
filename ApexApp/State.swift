//
//  State.swift
//  ApexApp
//
//  Created by Timothy Hang on 8/Two1/17.
//  Copyright © Two017 Timothy Hang. All rights reserved.
//

import Foundation
import Apex

struct CurrentState: State {
  var operandOne = ""
  var operandTwo = ""
  var operatorSymbol = ""
  var output = ""
  var result = "" {
    didSet {
      self.operandOne = String(result)
      self.operandTwo = ""
      self.operatorSymbol = ""
      output = result }
  }
  
  mutating func transition(_ action: Action)
  {
    var result = Double(self.output) ?? 0
    
    switch action {
    case Actions.operandTapped(let numberString):
      if operatorSymbol == "" {
        operandOne += numberString
        output = operandOne
      } else {
        operandTwo += numberString
        output = operandTwo
      }
    case Actions.operatorTapped(let operatorOption):
      switch operatorOption {
      case .add, .subtract, .multiply, .divide:
        operatorSymbol = operatorOption.rawValue
      case .clear: result = 0
        self.result = String("")
      case .plusMinus:
        if operandOne != "" && operandTwo == "" && operatorSymbol == "" {
        operandOne = String(Double(operandOne)! * -1)
        output = operandOne
        } else {
        operandTwo = String(Double(operandTwo)! * -1)
        output = operandTwo
        }
      
      case .squareRoot: result = sqrt(result)
        self.result = String(result)
      case .percent: result *= 100
        self.result = String(result)
      case .equals: let operandOne = Double(self.operandOne) ?? 0
        let operandTwo = Double(self.operandTwo) ?? 0

        switch operatorSymbol {
        case "+": result = operandOne + operandTwo
        case "-": result = operandOne - operandTwo
        case "*": result = operandOne * operandTwo
        case "/":
          if operandTwo != 0 { result = operandOne / operandTwo }
//          else { defer { self.output = "Cannot divide by 0" } }
        default: break
        }
        self.result = String(result)
      }
    default: break
    }
  }
}
