//
// SDPEncryptionConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPEncryptionModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPEncryptionViewControllerMock()
        let configurator = SDPEncryptionModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPEncryptionViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPEncryptionPresenter, "output is not SDPEncryptionPresenter")

        let presenter: SDPEncryptionPresenter = viewController.output as! SDPEncryptionPresenter
        XCTAssertNotNil(presenter.view, "view in SDPEncryptionPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPEncryptionPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPEncryptionRouter, "router is not SDPEncryptionRouter")

        let interactor: SDPEncryptionInteractor = presenter.interactor as! SDPEncryptionInteractor
        XCTAssertNotNil(interactor.output, "output in SDPEncryptionInteractor is nil after configuration")
    }

    class SDPEncryptionViewControllerMock: SDPEncryptionViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
