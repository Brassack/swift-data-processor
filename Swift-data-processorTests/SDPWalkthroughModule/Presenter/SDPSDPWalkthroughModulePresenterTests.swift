//
//  SDPSDPWalkthroughModuleSDPSDPWalkthroughModulePresenterTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 05/11/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPWalkthroughModulePresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: SDPWalkthroughModuleInteractorInput {

    }

    class MockRouter: SDPWalkthroughModuleRouterInput {
        func dismiss() {
            
        }
    }

    class MockViewController: SDPWalkthroughModuleViewInput {
        func set(pagesDataSource dataSource: SDPPagesControllerDataSource) {
            
        }
        
        func set(description: String) {
            
        }
    
        func setupInitialState() {

        }
    }
}
