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
    store.dispatch(action: Actions.operatorTapped(.equals))
		store.dispatch(action: Actions.operatorTapped(.plusMinus))
		
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
    }
  }
	
}
