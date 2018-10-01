//
//  SDPSDPSaltViewSDPSDPSaltViewConfiguratorTests.swift
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
        let viewController = SDPSaltViewViewControllerMock()
        let configurator = SDPSaltViewModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPSaltViewViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPSaltViewPresenter, "output is not SDPSaltViewPresenter")

        let presenter: SDPSaltViewPresenter = viewController.output as! SDPSaltViewPresenter
        XCTAssertNotNil(presenter.view, "view in SDPSaltViewPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPSaltViewPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPSaltViewRouter, "router is not SDPSaltViewRouter")

        let interactor: SDPSaltViewInteractor = presenter.interactor as! SDPSaltViewInteractor
        XCTAssertNotNil(interactor.output, "output in SDPSaltViewInteractor is nil after configuration")
    }

    class SDPSaltViewViewControllerMock: SDPSaltViewViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
