//
//  ViewController.swift
//  ApexApp
//
//  Created by Timothy Hang on 8/9/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import UIKit
import Apex

class ViewController: UIViewController
{
  lazy var store: Store<CalculatorBrain> = {
    return Store(state: self.state)
  }()
  let state = CalculatorBrain()
  
  @IBOutlet weak var plusButton: UIButton!
  @IBOutlet weak var minusButton: UIButton!
  @IBOutlet weak var equalsButton: UIButton!
  @IBOutlet weak var resultLabel: UILabel!
  
  var unsubscribers = [Unsubscriber]()

  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    store = Store(state: CalculatorBrain())
    
    store.subscribe
      {
        [unowned self] CalculatorBrain in
      self.resultLabel.text = String(CalculatorBrain.result)
      }.unsubscribed(by: &unsubscribers)
    
    plusButton.setTitle("+", for: .normal)
    minusButton.setTitle("-", for: .normal)
    equalsButton.setTitle("=", for: .normal)
    resultLabel.text = "0"
  }
  
  func buttonTapped(_ sender: UIButton)
  {
    switch sender
    {
    case plusButton: store.dispatch(action: Actions.plusTapped)
    case minusButton: store.dispatch(action: Actions.minusTapped)
    case equalsButton: store.dispatch(action: Actions.equalsTapped)
    default: break
    }
  }
}

extension ViewController
{
  enum Actions: Action {
    case plusTapped
    case minusTapped
    case equalsTapped
  }
}

extension ViewController
{
  struct CalculatorBrain: State
  {
    var operandOne = 1.0
    var operandTwo = 2.0
    var result = 0.0
    
    mutating func transition(_ action: Action) {
      switch action
      {
      case Actions.plusTapped:
        result = operandOne + operandTwo
      case Actions.minusTapped:
        result = operandOne - operandTwo
        //      case "*":
        //        result = String(operandOne * operandTwo)
        //      case "/":
        //        if operandTwo == 0
        //        {
        //          result = "Cannot / by 0"
        //        }
        //        else
        //        {
        //          result = String(operandOne / operandTwo)
      //        }
      default:
        result = 0.0
      }
      print(result)
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
