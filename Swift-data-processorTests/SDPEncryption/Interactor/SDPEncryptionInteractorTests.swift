//
// SDPEncryptionInteractorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPEncryptionInteractorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockPresenter: SDPEncryptionInteractorOutput {
        func set(text: String) {
            //TODO: add set(text:)
        }
        
        func set(data: Data) {
            //TODO: add set(data:)
        }
        
        func set(parameters: SDPEncryptionParameters?) {
            //TODO: add set(parameters:)
        }

    }
}
