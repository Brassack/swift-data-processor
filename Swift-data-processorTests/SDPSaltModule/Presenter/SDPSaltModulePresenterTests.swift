//
// SDPSaltModulePresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPSaltModulePresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPSaltModuleInteractorInput {
        func requestData() {
            //TODO: requestData
        }
        
        func subscribeForSaltClipboard() {
            //TODO: subscribeForSaltClipboard

        }
        
        func set(salt: String?) {
            //TODO: set(salt:)
        }
    }

    class MockRouter: SDPSaltModuleRouterInput {
        func pop() {
            //TODO: pop
        }
        
        func scanQR() {
            //TODO: scanQR
        }
    }

    class MockViewController: SDPSaltModuleViewInput {
        func set(salt: String?) {
            //TODO: set(salt:)
        }

        func setupInitialState() {
            //TODO: setupInitialState
        }
    }
}
