//
//  SDPRandomNumberParameterModuleSDPRandomNumberParameterModulePresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDRandomNumberParameterModulePresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPRandomNumberParameterModuleInteractorInput {
        
        func requestData() {
            //TODO: add requestData
        }
        
        func update(min: UInt32, max: UInt32) {
            //TODO: add update(min:max:)
        }
    }

    class MockRouter: SDPRandomNumberParameterModuleRouterInput {

    }

    class MockViewController: SDPRandomNumberParameterModuleViewInput {
        func set(result: String?) {
            //TODO: add set(result:)
        }
        
        func set(min: String) {
            //TODO: add set(min:)
        }
        
        func set(max: String) {
            //TODO: add set(max:)
        }
        
        func showMaxError() {
            //TODO: add showMaxError
        }
        
        func showMinError() {
            //TODO: add showMinError
        }
    
        func setupInitialState() {
            //TODO: add setupInitialState
        }
    }
}
