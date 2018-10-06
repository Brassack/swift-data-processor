//
// SDPEscapingModulePresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 03/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPEscapingModulePresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPEscapingModuleInteractorInput {
        func set(parameters: SDPEscapingModuleInteractor.EscapingParameters) {
            //TODO: set(parameters:)
        }
        
        func requestData() {
            //TODO: requestData
        }
    }

    class MockRouter: SDPEscapingModuleRouterInput {
        func share(text: String) {
            //TODO: share(:text:)
        }
    }

    class MockViewController: SDPEscapingModuleViewInput {
        func prepareForScreen() {
            //TODO: prepareForScreen
        }
        
        func setup(pickerOptions: [SDPPickerSingleOptionInput.Value], defaultValue: SDPPickerSingleOptionInput.Value?) {
            //TODO: setup(pickerOptions:defaultValue)
        }
        
        func show(text: String?) {
            //TODO: show(text:)
        }
        
        func setupInitialState() {
            //TODO: setupInitialState
        }
    }
}
