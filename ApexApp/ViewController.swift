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
  var store: Store<CalculatorBrain>!
  
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
  }
  
  func buttonTapped(_ sender: UIButton)
  {
    switch sender
    {
    case plusButton: store.dispatch(action: plusTapped())
    case minusButton: store.dispatch(action: minusTapped())
    case equalsButton: store.dispatch(action: equalsTapped())
    default: break
    }
  }
}

struct plusTapped: Action{}
struct minusTapped: Action{}
struct equalsTapped: Action{}

struct CalculatorBrain: State
{
  var operandOne = "1"
  var operandTwo = "2"
  var operationSymbol = String()
  var result = String()
  
  mutating func calculate()
  {
    result = operandOne + operationSymbol + operandTwo
    print(result)
  }
  
  mutating func transition(_ action: Action)
  {
    switch action
    {
    case is plusTapped: operationSymbol = "+"
    case is minusTapped: operationSymbol = "-"
    case is equalsTapped: calculate()
    default: break
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
