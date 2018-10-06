//
// SDPPasswordBasedKeyConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPPasswordBasedKeyModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = SDPPasswordBasedKeyViewControllerMock()
        let configurator = SDPPasswordBasedKeyModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPPasswordBasedKeyViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPPasswordBasedKeyPresenter, "output is not SDPPasswordBasedKeyPresenter")

        let presenter: SDPPasswordBasedKeyPresenter = viewController.output as! SDPPasswordBasedKeyPresenter
        XCTAssertNotNil(presenter.view, "view in SDPPasswordBasedKeyPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPPasswordBasedKeyPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPPasswordBasedKeyRouter, "router is not SDPPasswordBasedKeyRouter")

        let interactor: SDPPasswordBasedKeyInteractor = presenter.interactor as! SDPPasswordBasedKeyInteractor
        XCTAssertNotNil(interactor.output, "output in SDPPasswordBasedKeyInteractor is nil after configuration")
    }

    class SDPPasswordBasedKeyViewControllerMock: SDPPasswordBasedKeyViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
