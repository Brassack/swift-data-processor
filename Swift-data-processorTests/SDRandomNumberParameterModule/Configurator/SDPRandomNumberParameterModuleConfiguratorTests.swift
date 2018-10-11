//
//  SDPRandomNumberParameterModuleSDPRandomNumberParameterModuleConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPRandomNumberParameterModuleModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPRandomNumberParameterModuleViewControllerMock()
        let configurator = SDPRandomNumberParameterModuleModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPRandomNumberParameterModuleViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPRandomNumberParameterModulePresenter, "output is not SDRandomNumberParameterModulePresenter")

        let presenter: SDPRandomNumberParameterModulePresenter = viewController.output as! SDPRandomNumberParameterModulePresenter
        XCTAssertNotNil(presenter.view, "view in SDRandomNumberParameterModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDRandomNumberParameterModulePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPRandomNumberParameterModuleRouter, "router is not SDRandomNumberParameterModuleRouter")

        let interactor: SDPRandomNumberParameterModuleInteractor = presenter.interactor as! SDPRandomNumberParameterModuleInteractor
        XCTAssertNotNil(interactor.output, "output in SDRandomNumberParameterModuleInteractor is nil after configuration")
    }

    class SDPRandomNumberParameterModuleViewControllerMock: SDPRandomNumberParameterModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
