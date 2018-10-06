//
// SDPQRGeneratorConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPQRGeneratorModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPQRGeneratorViewControllerMock()
        let configurator = SDPQRGeneratorModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPQRGeneratorViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPQRGeneratorPresenter, "output is not SDPQRGeneratorPresenter")

        let presenter: SDPQRGeneratorPresenter = viewController.output as! SDPQRGeneratorPresenter
        XCTAssertNotNil(presenter.view, "view in SDPQRGeneratorPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPQRGeneratorPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPQRGeneratorRouter, "router is not SDPQRGeneratorRouter")

        let interactor: SDPQRGeneratorInteractor = presenter.interactor as! SDPQRGeneratorInteractor
        XCTAssertNotNil(interactor.output, "output in SDPQRGeneratorInteractor is nil after configuration")
    }

    class SDPQRGeneratorViewControllerMock: SDPQRGeneratorViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
