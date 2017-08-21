//
//  State.swift
//  ApexApp
//
//  Created by Timothy Hang on 8/21/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import Foundation
import Apex

struct CurrentState: State
{
  var operandOne = ""
  var operandTwo = ""
  var operationSymbol = ""
  var result = ""
  var number = ""
  
  mutating func transition(_ action: Action)
  {
    switch action
    {
    case Actions.operandOneTapped: operandOne += number
    case Actions.operandTwoTapped: operandTwo += number
      
      
      case Actions.addTapped: operationSymbol = "+"
      case Actions.subtractTapped: operationSymbol = "-"
      case Actions.multiplyTapped: operationSymbol = "*"
      case Actions.divideTapped: operationSymbol = "/"
        
      case Actions.equalsTapped:
        switch operationSymbol
        {
        case "+":
          result = String(Double(operandOne)! + Double(operandTwo)!)
        case "-":
          result = String(Double(operandOne)! - Double(operandTwo)!)
        case "*":
          result = String(Double(operandOne)!*Double(operandTwo)!)
        case "/":
          if operandTwo == "0"
          {
            result = "Cannot / by 0"
          }
          else
          {
            result = String(Double(operandOne)!/Double(operandTwo)!)
          }
        default: break
        }
      case Actions.plusMinusTapped: result = String(Double(result)! * -1.0)
      case Actions.sqrtTapped: result = String(sqrt(Double(result)!))
      case Actions.clearTapped: result = "0"
      case Actions.percentTapped: result = String(Double(result)! * 100)
      default: break
    }
  }
}
