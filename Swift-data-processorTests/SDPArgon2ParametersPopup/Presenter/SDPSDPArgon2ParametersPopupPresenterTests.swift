//
//  SDPSDPArgon2ParametersPopupSDPSDPArgon2ParametersPopupPresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 27/08/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPArgon2ParametersPopupPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPArgon2ParametersPopupInteractorInput {

    }

    class MockRouter: SDPArgon2ParametersPopupRouterInput {

    }

    class MockViewController: SDPArgon2ParametersPopupViewInput {

        func setupInitialState() {

        }
    }
}
