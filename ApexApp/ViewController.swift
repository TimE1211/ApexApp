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
  
  var state = CurrentState()
  
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var operationSymbolLabel: UILabel!
  
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
    
    resultLabel.text = "0"
    
    store = Store(state: CurrentState())
    store.subscribe { [unowned self] state in
      self.resultLabel.text = state.output
      self.operationSymbolLabel.text = state.operatorSymbol
      }.unsubscribed(by: &unsubscribers)
  }
  
  @IBAction func operationSymbolTapped(_ sender: UIButton) {
    switch sender {
    case addButton:
      store.dispatch(action: Actions.operatorTapped(.add))
    case subtractButton:
      store.dispatch(action: Actions.operatorTapped(.subtract))
    case equalsButton:
      store.dispatch(action: Actions.operatorTapped(.equals))
    case multiplyButton:
      store.dispatch(action: Actions.operatorTapped(.multiply))
    case divideButton:
      store.dispatch(action: Actions.operatorTapped(.divide))
    case plusMinusButton:
      store.dispatch(action: Actions.operatorTapped(.plusMinus))
    case sqrtButton:
      store.dispatch(action: Actions.operatorTapped(.squareRoot))
    case clearButton:
      store.dispatch(action: Actions.operatorTapped(.clear))
    case percentButton:
      store.dispatch(action: Actions.operatorTapped(.percent))
    default: break
    }
  }
  
  @IBAction func operandTapped(sender: UIButton) {
    guard let numberString = sender.currentTitle else { return }
    store.dispatch(action: Actions.operandTapped(numberString))
  }
}

extension Unsubscriber {
  func unsubscribed(by unsubscribers: inout [Unsubscriber]) {
    unsubscribers.append(self)
  }
}
