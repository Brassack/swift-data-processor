//
//  SDPSDPSaltViewSDPSDPSaltViewPresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPSaltViewPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPSaltViewInteractorInput {

    }

    class MockRouter: SDPSaltViewRouterInput {

    }

    class MockViewController: SDPSaltViewViewInput {

        func setupInitialState() {

        }
    }
}
