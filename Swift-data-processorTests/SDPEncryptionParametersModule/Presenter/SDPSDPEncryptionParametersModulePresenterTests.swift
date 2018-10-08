//
//  SDPSDPEncryptionParametersModuleSDPSDPEncryptionParametersModulePresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 08/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPEncryptionParametersModulePresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPEncryptionParametersModuleInteractorInput {
        func requestParameters() {
            //TODO: requestParameters
        }
        
        func update(parameters: SDPEncryptionParameters?) {
            //TODO: update(parameters:)
        }
    }

    class MockRouter: SDPEncryptionParametersModuleRouterInput {
        
        func set(page: Any, forPageController: Any, direction: SDPEncryptionParametersModulePresenter.Direction) {
            //MARK: set(page:forPageController:direction:)
        }
    }

    class MockViewController: SDPEncryptionParametersModuleViewInput {
        func set(methodPickerValues: [SDPPickerSingleOptionInput.Value], defaultValue: SDPPickerSingleOptionInput.Value?) {
            //MARK: set(methodPickerValues:defaultValue:)
        }
        
        func set(keySizesPickerValues: [SDPPickerSingleOptionInput.Value], defaultValue: SDPPickerSingleOptionInput.Value?) {
            //MARK: set(keySizesPickerValues:defaultValue:)
        }

        func setupInitialState() {
            //MARK: setupInitialState
        }
    }
}
