//
//  SDPArgon2ParametersPopupSDPArgon2ParametersPopupConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 27/08/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPArgon2ParametersPopupModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPArgon2ParametersPopupViewControllerMock()
        let configurator = SDPArgon2ParametersPopupModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPArgon2ParametersPopupViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPArgon2ParametersPopupPresenter, "output is not SDPArgon2ParametersPopupPresenter")

        let presenter: SDPArgon2ParametersPopupPresenter = viewController.output as! SDPArgon2ParametersPopupPresenter
        XCTAssertNotNil(presenter.view, "view in SDPArgon2ParametersPopupPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPArgon2ParametersPopupPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPArgon2ParametersPopupRouter, "router is not SDPArgon2ParametersPopupRouter")

        let interactor: SDPArgon2ParametersPopupInteractor = presenter.interactor as! SDPArgon2ParametersPopupInteractor
        XCTAssertNotNil(interactor.output, "output in SDPArgon2ParametersPopupInteractor is nil after configuration")
    }

    class SDPArgon2ParametersPopupViewControllerMock: SDPArgon2ParametersPopupView {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
