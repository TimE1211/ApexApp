//
//  Actions.swift
//  
//
//  Created by Timothy Hang on 8/21/17.
//
//

import Foundation
import Apex

import Foundation
import Apex

enum Actions: Action
{
  case operandTapped(String)        //associated values in enums
  
  case operatorTapped(Operator)
}

enum Operator: String
{
  case add = "+"
  case subtract = "-"
  case equals
  case multiply = "*"
  case divide = "/"
  
  case plusMinus
  case squareRoot
  case percent
  
  case clear
}
