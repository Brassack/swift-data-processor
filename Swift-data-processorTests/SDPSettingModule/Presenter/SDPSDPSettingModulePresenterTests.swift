//
//  SDPSDPSettingModuleSDPSDPSettingModulePresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 12/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPSettingModulePresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPSettingModuleInteractorInput {

    }

    class MockRouter: SDPSettingModuleRouterInput {
        func showColorPicker(color: Any, completion: @escaping (Any) -> Void) {
            //TODO: add showColorPicker(color:completion:)
        }
        
        func showCredits() {
            //TODO: add showCredits
        }
    }

    class MockViewController: SDPSettingModuleViewInput {
        func set(dataSource: SDPMulticlassTableViewDataSource?) {
            //TODO: add set(dataSource:)
        }

        func setupInitialState() {
            //TODO: add setupInitialState
        }
    }
}
