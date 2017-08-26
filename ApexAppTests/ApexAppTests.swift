//
//  ApexAppTests.swift
//  ApexAppTests
//
//  Created by Daniel Tartaglia on 8/25/17.
//  Copyright © 2017 Timothy Hang. All rights reserved.
//

import XCTest
import Apex
@testable import ApexApp

class ApexAppTests: XCTestCase {
	
	func testMultiplyByNegative() {
		let store = Store<CurrentState>(state: CurrentState())
		store.dispatch(action: Actions.operandTapped("5"))
		store.dispatch(action: Actions.operatorTapped(.multiply))
		store.dispatch(action: Actions.operandTapped("3"))
		store.dispatch(action: Actions.operatorTapped(.plusMinus))
    store.dispatch(action: Actions.operatorTapped(.equals))
		
		_ = store.subscribe { state in
			XCTAssertEqual(state.output, "-15.0")
		}
	}
  
  func testClear() {
    let store = Store<CurrentState>(state: CurrentState())
    store.dispatch(action: Actions.operandTapped("5"))
    store.dispatch(action: Actions.operatorTapped(.multiply))
    store.dispatch(action: Actions.operandTapped("3"))
    store.dispatch(action: Actions.operatorTapped(.equals))
    store.dispatch(action: Actions.operatorTapped(.clear))
    
    _ = store.subscribe { state in
      XCTAssertEqual(state.output, "")
      XCTAssertEqual(state.operandOne, "")
      XCTAssertEqual(state.operandTwo, "")
      XCTAssertEqual(state.operatorSymbol, "")
    }
  }
  
//  func testDivideByZero() {
//    let store = Store<CurrentState>(state: CurrentState())
//    store.dispatch(action: Actions.operandTapped("1"))
//    store.dispatch(action: Actions.operatorTapped(.divide))
//    store.dispatch(action: Actions.operandTapped("0"))
//    store.dispatch(action: Actions.operatorTapped(.equals))
//    
//    _ = store.subscribe { state in
//      XCTAssertEqual(state.output, "Cannot divide by 0")
//    }
//  }
	
}
