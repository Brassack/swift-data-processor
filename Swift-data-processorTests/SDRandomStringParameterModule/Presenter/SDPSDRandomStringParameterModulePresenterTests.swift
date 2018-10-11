//
//  SDPRandomStringParameterModuleSDPRandomStringParameterModulePresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDRandomStringParameterModulePresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPRandomTextParameterModuleInteractorInput {
        func requestData() {
            //TODO: add requestData
        }
        
        func set(subtype: SDPRandomParametersState.RandomTextSubtype) {
            //TODO: set(subtype:)
        }
        
        func set(count: Int) {
            //TODO: set(count:)
        }
    }

    class MockRouter: SDPRandomTextParameterModuleRouterInput {

    }

    class MockViewController: SDPRandomTextParameterModuleViewInput {
        func set(tableViewDataSource: SDPOrdinaryTableViewDataSource) {
            //TODO: set(tableViewDataSource:)
        }
        
        func set(textInputDescription: String?) {
            //TODO: set(textInputDescription:)
        }
        
        func set(count: String) {
            //TODO: set(count:)
        }
        
        func set(countInputVisible: Bool) {
            //TODO: add set(countInputVisible:)
        }
        
        func set(limitation: String) {
            //TODO: add set(limitation:)
        }
        
        func showCountError() {
            //TODO: add showCountError
        }

        func setupInitialState() {
            //TODO: add setupInitialState
        }
    }
}
