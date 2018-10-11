//
//  SDPRandomBinaryParametersModuleSDPRandomBinaryParametersModuleInteractorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDRandomBinaryParametersModuleInteractorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockPresenter: SDPRandomBinaryParametersModuleInteractorOutput {
        func incorrectDataPassed() {
            //TODO: add incorrectDataPassed
        }
        
        func set(state: SDPRandomParametersState?) {
            //TODO: add set(state:)
        }
    }
}
