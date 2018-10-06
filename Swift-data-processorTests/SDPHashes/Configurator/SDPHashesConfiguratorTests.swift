//
// SDPHashesConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPHashesModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPHashesViewControllerMock()
        let configurator = SDPHashesModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPHashesViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPHashesPresenter, "output is not SDPHashesPresenter")

        let presenter: SDPHashesPresenter = viewController.output as! SDPHashesPresenter
        XCTAssertNotNil(presenter.view, "view in SDPHashesPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPHashesPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPHashesRouter, "router is not SDPHashesRouter")

        let interactor: SDPHashesInteractor = presenter.interactor as! SDPHashesInteractor
        XCTAssertNotNil(interactor.output, "output in SDPHashesInteractor is nil after configuration")
    }

    class SDPHashesViewControllerMock: SDPHashesViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
