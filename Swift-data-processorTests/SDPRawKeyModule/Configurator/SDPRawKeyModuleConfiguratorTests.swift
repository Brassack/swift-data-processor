//
// SDPRawKeyModuleConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPRawKeyModuleModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPRawKeyModuleViewControllerMock()
        let configurator = SDPRawKeyModuleModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPRawKeyModuleViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPRawKeyModulePresenter, "output is not SDPRawKeyModulePresenter")

        let presenter: SDPRawKeyModulePresenter = viewController.output as! SDPRawKeyModulePresenter
        XCTAssertNotNil(presenter.view, "view in SDPRawKeyModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPRawKeyModulePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPRawKeyModuleRouter, "router is not SDPRawKeyModuleRouter")

        let interactor: SDPRawKeyModuleInteractor = presenter.interactor as! SDPRawKeyModuleInteractor
        XCTAssertNotNil(interactor.output, "output in SDPRawKeyModuleInteractor is nil after configuration")
    }

    class SDPRawKeyModuleViewControllerMock: SDPRawKeyModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
