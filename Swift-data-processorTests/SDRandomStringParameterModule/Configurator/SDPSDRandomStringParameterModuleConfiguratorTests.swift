//
//  SDPRandomStringParameterModuleSDPRandomStringParameterModuleConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDRandomStringParameterModuleModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPRandomTextParameterModuleViewControllerMock()
        let configurator = SDPRandomTextParameterModuleModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDRandomStringParameterModuleViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPRandomTextParameterModulePresenter, "output is not SDRandomStringParameterModulePresenter")

        let presenter: SDPRandomTextParameterModulePresenter = viewController.output as! SDPRandomTextParameterModulePresenter
        XCTAssertNotNil(presenter.view, "view in SDRandomStringParameterModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDRandomStringParameterModulePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPRandomTextParameterModuleRouter, "router is not SDRandomStringParameterModuleRouter")

        let interactor: SDPRandomTextParameterModuleInteractor = presenter.interactor as! SDPRandomTextParameterModuleInteractor
        XCTAssertNotNil(interactor.output, "output in SDRandomStringParameterModuleInteractor is nil after configuration")
    }

    class SDPRandomTextParameterModuleViewControllerMock: SDPRandomTextParameterModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
