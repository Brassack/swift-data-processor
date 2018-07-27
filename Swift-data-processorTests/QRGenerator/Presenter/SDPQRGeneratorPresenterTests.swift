//
//  SDPQRGeneratorSDPQRGeneratorPresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class QRGeneratorPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: QRGeneratorInteractorInput {

    }

    class MockRouter: QRGeneratorRouterInput {

    }

    class MockViewController: QRGeneratorViewInput {

        func setupInitialState() {

        }
    }
}
