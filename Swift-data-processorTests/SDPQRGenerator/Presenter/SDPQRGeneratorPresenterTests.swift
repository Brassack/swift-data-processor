//
// SDPQRGeneratorPresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPQRGeneratorPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPQRGeneratorInteractorInput {
        //TODO: DI
        var stores: SDPReduxStores = SDPReduxStores.shared
        
        func requestClipboardData() {
            //TODO: add requestClipboardData
        }
        

    }

    class MockRouter: SDPQRGeneratorRouterInput {
        func share(image: UIImage) {
            //TODO: add share(imaage:)
        }
    }

    class MockViewController: SDPQRGeneratorViewInput {
        func prepareFoorScreen() {
            //TODO: add prepareFoorScreen
        }
        
        func show(qrImage: UIImage) {
            //TODO: add show(qrImage:)
        }
        
        func show(errorMessage: String) {
            //TODO: add show(errorMessage:)
        }

        func setupInitialState() {
            //TODO: add setupInitialState
        }
    }
}
