//
//  SDPSDPSaltModuleSDPSDPSaltModuleConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPSaltModuleModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPSaltModuleViewControllerMock()
        let configurator = SDPSaltModuleModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPSaltModuleViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPSaltModulePresenter, "output is not SDPSaltModulePresenter")

        let presenter: SDPSaltModulePresenter = viewController.output as! SDPSaltModulePresenter
        XCTAssertNotNil(presenter.view, "view in SDPSaltModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPSaltModulePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPSaltModuleRouter, "router is not SDPSaltModuleRouter")

        let interactor: SDPSaltModuleInteractor = presenter.interactor as! SDPSaltModuleInteractor
        XCTAssertNotNil(interactor.output, "output in SDPSaltModuleInteractor is nil after configuration")
    }

    class SDPSaltModuleViewControllerMock: SDPSaltModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
