//
// SDPHashesPresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPHashesPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPHashesInteractorInput {
        
        func setupAndSubscripeToArgon2Parameters() {
            //TODO: setupAndSubscripeToArgon2Parameters
        }
        
        func unsubscribeFromArgon2Clipboard() {
            //TODO: unsubscribeFromArgon2Clipboard
        }
        
        func unsubscribeFromSaltClipboard() {
            //TODO: unsubscribeFromSaltClipboard
        }
        
        func subscribeForSaltClipboard() {
            //TODO: subscribeForSaltClipboard
        }
        
        func requestData(_: (iterations: Int, salt: String?)) {
            //TODO: requestData(_:)
        }
    }

    class MockRouter: SDPHashesRouterInput {
        func share(hash: String) {
            //TODO: share(hash:)
        }
        
        func scanQR() {
            //TODO: scanQR
        }
        
        func argon2Parameters() {
            //TODO: argon2Parameters
        }
        
        func returnTo(view: UIViewController) {
            //TODO: returnTo(view:)
        }
    }

    class MockViewController: SDPHashesViewInput {
        func showError(forTextField textField: Any?, fallbackValue: String?) {
            //TODO: showError(forTextField: fallbackValue:)
        }
        
        func setTableDataSource(_ dataSource: UITableViewDataSource) {
            //TODO: setTableDataSource(_:)
        }
        
        func prepareForScreen() {
            //TODO: prepareForScreen
        }
        
        func set(salt: String?) {
            //TODO: set(salt:)
        }
        
        func refreshSaltActions() {
            //TODO: refreshSaltActions
        }
        
        func setupInitialState() {
            //TODO: refreshSaltActions
        }
    }
}
