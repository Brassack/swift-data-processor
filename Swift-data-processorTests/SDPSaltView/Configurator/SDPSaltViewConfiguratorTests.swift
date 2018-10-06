//
// SDPSaltViewConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPSaltViewModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPSalModuleViewControllerMock()
        let configurator = SDPSaltModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPSaltViewViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPSaltModulePresenter, "output is not SDPSaltViewPresenter")

        let presenter: SDPSaltModulePresenter = viewController.output as! SDPSaltModulePresenter
        XCTAssertNotNil(presenter.view, "view in SDPSaltViewPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPSaltViewPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPSaltModuleRouter, "router is not SDPSaltViewRouter")

        let interactor: SDPSaltModuleInteractor = presenter.interactor as! SDPSaltModuleInteractor
        XCTAssertNotNil(interactor.output, "output in SDPSaltViewInteractor is nil after configuration")
    }

    class SDPSalModuleViewControllerMock: SDPSaltModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
