//
//  SDPRandomModuleSDPRandomModulePresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDRandomModulePresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPRandomModuleInteractorInput {
        func random() {
            //TODO: add random
        }
        
        func set(type: SDPRandomParametersState.RandomType) {
            //TODO: add set(type:)
        }
        
        func requestData() {
            //TODO:add requestData
        }
    }

    class MockRouter: SDPRandomModuleRouterInput {
        func set(page: Any, forPageController: Any, direction: SDRandomModulePresenter.Direction) {
            //TODO: add set(page:forPageController:direction:)
        }
        
        func share(text: String) {
            //TODO: add share(text:)
        }
        
        func share(data: Data) {
            //TODO: add share(data:)
        }
    }

    class MockViewController: SDPRandomModuleViewInput {
        func set(randomTypes: [String]) {
            //TODO: add set(randomTypes:)
        }
        

        func setupInitialState() {
            //TODO: setupInitialState
        }
    }
}
