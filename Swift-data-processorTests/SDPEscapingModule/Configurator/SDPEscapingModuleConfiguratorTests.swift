//
// SDPEscapingModuleConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 03/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPEscapingModuleModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPEscapingModuleViewControllerMock()
        let configurator = SDPEscapingModuleModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPEscapingModuleViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPEscapingModulePresenter, "output is not SDPEscapingModulePresenter")

        let presenter: SDPEscapingModulePresenter = viewController.output as! SDPEscapingModulePresenter
        XCTAssertNotNil(presenter.view, "view in SDPEscapingModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPEscapingModulePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPEscapingModuleRouter, "router is not SDPEscapingModuleRouter")

        let interactor: SDPEscapingModuleInteractor = presenter.interactor as! SDPEscapingModuleInteractor
        XCTAssertNotNil(interactor.output, "output in SDPEscapingModuleInteractor is nil after configuration")
    }

    class SDPEscapingModuleViewControllerMock: SDPEscapingModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
