//
// SDPEncryptionPresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPEncryptionPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPEncryptionInteractorInput {
        
        func requestClipboardData() {
            //TODO: add requestClipboardData
        }
        
        func setupParameters(withKeySize: Int) {
            //TODO: add setupParameters(withKeySize:)
        }
    }

    class MockRouter: SDPEncryptionRouterInput {
        func set(page: UIViewController, forPageController: UIPageViewController, direction: UIPageViewController.NavigationDirection) {
            //TODO: add set(page:forPageController:direction:)
        }
        
        func share(data: Data) {
            //TODO: add share(data:)
        }
    }

    class MockViewController: SDPEncryptionViewInput {
        
        func prepareForScreen() {
            //TODO: add prepareForScreen
        }
        
        func set(state: SDPEncryptionViewController.SDEncryptionState) {
            //TODO: add set(state:)
        }
        
        func set(methodPickerValues: [SDPPickerSingleOptionInput.Value], defaultValue: SDPPickerSingleOptionInput.Value?) {
            //TODO: add set(methodPickerValues:defaultValue:)
        }
        
        func set(keySizesPickerValues: [SDPPickerSingleOptionInput.Value], defaultValue: SDPPickerSingleOptionInput.Value?) {
            //TODO: add set(keySizesPickerValues:defaultValue:)
        }
        
        func set(title: String?) {
            //TODO: add set(title:)
        }
        
        func setupInitialState() {
            //TODO: add setupInitialState
        }
    }
}
