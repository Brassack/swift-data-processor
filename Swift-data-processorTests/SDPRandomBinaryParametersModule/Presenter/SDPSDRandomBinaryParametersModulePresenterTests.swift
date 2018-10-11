//
//  SDPRandomBinaryParametersModuleSDPRandomBinaryParametersModulePresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDRandomBinaryParametersModulePresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPRandomBinaryParametersModuleInteractorInput {
        func requestData() {
            //TODO: add requestData
        }
        
        func set(count: Int) {
            //TODO: add set(count:)
        }
    }

    class MockRouter: SDPRandomBinaryParametersModuleRouterInput {

    }

    class MockViewController: SDPRandomBinaryParametersModuleViewInput {
        func set(count: String) {
            //TODO: add set(count:)
        }
        
        func set(hex: String) {
            //TODO: add set(hex:)
        }
        
        func showError() {
            //TODO: add showError
        }
        
        func setupInitialState() {
            //TODO: add setupInitialState
        }
    }
}
