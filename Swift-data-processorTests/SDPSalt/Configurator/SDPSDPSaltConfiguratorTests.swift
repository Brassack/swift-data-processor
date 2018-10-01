//
//  SDPSDPSaltSDPSDPSaltConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPSaltModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPSaltViewControllerMock()
        let configurator = SDPSaltModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPSaltViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPSaltPresenter, "output is not SDPSaltPresenter")

        let presenter: SDPSaltPresenter = viewController.output as! SDPSaltPresenter
        XCTAssertNotNil(presenter.view, "view in SDPSaltPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPSaltPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPSaltRouter, "router is not SDPSaltRouter")

        let interactor: SDPSaltInteractor = presenter.interactor as! SDPSaltInteractor
        XCTAssertNotNil(interactor.output, "output in SDPSaltInteractor is nil after configuration")
    }

    class SDPSaltViewControllerMock: SDPSaltViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
