//
//  SDPRandomModuleSDPRandomModuleConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDRandomModuleModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPRandomModuleViewControllerMock()
        let configurator = SDPRandomModuleModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPRandomModuleViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDRandomModulePresenter, "output is not SDRandomModulePresenter")

        let presenter: SDRandomModulePresenter = viewController.output as! SDRandomModulePresenter
        XCTAssertNotNil(presenter.view, "view in SDPRandomModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPRandomModulePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPRandomModuleRouter, "router is not SDPRandomModuleRouter")

        let interactor: SDRandomModuleInteractor = presenter.interactor as! SDRandomModuleInteractor
        XCTAssertNotNil(interactor.output, "output in SDRandomModuleInteractor is nil after configuration")
    }

    class SDPRandomModuleViewControllerMock: SDPRandomModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
