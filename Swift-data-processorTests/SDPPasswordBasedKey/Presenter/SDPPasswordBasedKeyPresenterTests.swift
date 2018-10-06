//
// SDPPasswordBasedKeyPresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPPasswordBasedKeyPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPPasswordBasedKeyInteractorInput {
        func requestData() {
            //TODO: requestData
        }
        
        func subscribeForSaltClipboard() {
            //TODO: subscribeForSaltClipboard
        }
        
        func set(parameters: SDPEncryptionParameters?) {
            //TODO: set(parameters:)
        }
        

    }

    class MockRouter: SDPPasswordBasedKeyRouterInput {
        func pop() {
            //TODO: pop
        }
        
        func scanQR() {
            //TODO: scanQR
        }
        
        func showSaltView(intoView: UIView, forParent: UIViewController) {
            //TODO: showSaltView(intoView: forParent:)
        }
        
        func share(text: String) {
            //TODO: share(text:)
        }
    }

    class MockViewController: SDPPasswordBasedKeyViewInput {
        func set(password: String?) {
            //TODO: set(password:)
        }
        
        func set(rawKeyString: String?) {
            //TODO:set(rawKeyString:)
        }

        func setupInitialState() {
            //TODO: setupInitialState
        }
    }
}
