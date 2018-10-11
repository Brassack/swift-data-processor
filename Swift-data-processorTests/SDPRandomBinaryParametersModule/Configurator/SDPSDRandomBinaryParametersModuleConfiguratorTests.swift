//
//  SDPRandomBinaryParametersModuleSDPRandomBinaryParametersModuleConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPRandomBinaryParametersModuleModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPRandomBinaryParametersModuleViewControllerMock()
        let configurator = SDPRandomBinaryParametersModuleModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPRandomBinaryParametersModuleViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPRandomBinaryParametersModulePresenter, "output is not SDPRandomBinaryParametersModulePresenter")

        let presenter: SDPRandomBinaryParametersModulePresenter = viewController.output as! SDPRandomBinaryParametersModulePresenter
        XCTAssertNotNil(presenter.view, "view in SDRandomBinaryParametersModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDRandomBinaryParametersModulePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPRandomBinaryParametersModuleRouter, "router is not SDRandomBinaryParametersModuleRouter")

        let interactor: SDPRandomBinaryParametersModuleInteractor = presenter.interactor as! SDPRandomBinaryParametersModuleInteractor
        XCTAssertNotNil(interactor.output, "output in SDRandomBinaryParametersModuleInteractor is nil after configuration")
    }

    class SDPRandomBinaryParametersModuleViewControllerMock: SDPRandomBinaryParametersModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
