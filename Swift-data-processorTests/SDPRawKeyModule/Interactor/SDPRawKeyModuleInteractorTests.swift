//
// SDPRawKeyModuleInteractorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPRawKeyModuleInteractorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockPresenter: SDPRawKeyModuleInteractorOutput {
        func set(parameters: SDPEncryptionParameters) {
            //TODO: set(parameterd:)
        }    
    }
}
