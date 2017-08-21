//
//  ViewController.swift
//  ApexApp
//
//  Created by Timothy Hang on 8/9/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import UIKit
import Apex

class CalculatorViewController: UIViewController
{
  lazy var store: Store<CurrentState> = {
    return Store(state: self.state)
  }()
  let state = CurrentState()
  
  @IBOutlet weak var resultLabel: UILabel!
  
  @IBOutlet weak var clearButton: UIButton!
  @IBOutlet weak var plusMinusButton: UIButton!
  @IBOutlet weak var sqrtButton: UIButton!
  @IBOutlet weak var percentButton: UIButton!
  
  @IBOutlet weak var divideButton: UIButton!
  @IBOutlet weak var multiplyButton: UIButton!
  @IBOutlet weak var subtractButton: UIButton!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var equalsButton: UIButton!
  
  @IBOutlet weak var decimalButton: UIButton!
  @IBOutlet weak var oneButton: UIButton!
  @IBOutlet weak var twoButton: UIButton!
  @IBOutlet weak var threeButton: UIButton!
  @IBOutlet weak var fourButton: UIButton!
  @IBOutlet weak var fiveButton: UIButton!
  @IBOutlet weak var sixButton: UIButton!
  @IBOutlet weak var sevenButton: UIButton!
  @IBOutlet weak var eightButton: UIButton!
  @IBOutlet weak var nineButton: UIButton!
  @IBOutlet weak var zeroButton: UIButton!
  
  var unsubscribers = [Unsubscriber]()
  
  var number = ""

  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    store = Store(state: CurrentState())
    store.subscribe
      {
        [unowned self] CurrentState in
      self.resultLabel.text = String(CurrentState.result)
      }.unsubscribed(by: &unsubscribers)
    
    resultLabel.text = "0"
  }
  
//  @IBAction func plusTouchUpInside(_ sender: UIButton)
//  {
//    store.dispatch(action: Actions.plusTapped)
//  }
  
  @IBAction func operationSymbolTapped(_ sender: UIButton)
  {
    switch sender
    {
      case addButton: store.dispatch(action: Actions.addTapped)
      case subtractButton: store.dispatch(action: Actions.subtractTapped)
      case equalsButton: store.dispatch(action: Actions.equalsTapped)
      case multiplyButton: store.dispatch(action: Actions.multiplyTapped)
      case divideButton: store.dispatch(action: Actions.divideTapped)
      
      case plusMinusButton: store.dispatch(action: Actions.plusMinusTapped)
      case sqrtButton: store.dispatch(action: Actions.sqrtTapped)
      case clearButton: store.dispatch(action: Actions.clearTapped)
      case percentButton: store.dispatch(action: Actions.percentTapped)
      default: break
    }
  }
  @IBAction func operatorTapped(sender: UIButton)
  {
    if state.operationSymbol == ""
    {
      store.dispatch(action: Actions.operandOneTapped(number: sender.currentTitle!))
    }
    else
    {
      store.dispatch(action: Actions.operandTwoTapped(number: sender.currentTitle!))
      number = sender.currentTitle!
    }
  }
}

extension CalculatorViewController
{
  enum Actions: Action
  {
    case operandOneTapped(number: String)
    case operandTwoTapped(number: String)
    
    case addTapped
    case subtractTapped
    case equalsTapped
    case multiplyTapped
    case divideTapped
    
    case plusMinusTapped
    case sqrtTapped
    case clearTapped
    case percentTapped
  }
}

extension CalculatorViewController
{
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
}

extension Unsubscriber
{
  func unsubscribed(by unsubscribers: inout [Unsubscriber])
  {
    unsubscribers.append(self)
  }
}
