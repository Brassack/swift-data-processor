//
//  SDPPEncryptionParametersModuleSDPPEncryptionParametersModuleConfiguratorTests.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 08/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import XCTest

class SDPEncryptionParametersModuleModuleConfiguratorTests: XCTestCase {

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
        let viewController = SDPEncryptionParametersModuleViewControllerMock()
        let configurator = SDPEncryptionParametersModuleModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SDPEncryptionParametersModuleViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SDPEncryptionParametersModulePresenter, "output is not SDPEncryptionParametersModulePresenter")

        let presenter: SDPEncryptionParametersModulePresenter = viewController.output as! SDPEncryptionParametersModulePresenter
        XCTAssertNotNil(presenter.view, "view in SDPEncryptionParametersModulePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SDPEncryptionParametersModulePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SDPEncryptionParametersModuleRouter, "router is not SDPEncryptionParametersModuleRouter")

        let interactor: SDPEncryptionParametersModuleInteractor = presenter.interactor as! SDPEncryptionParametersModuleInteractor
        XCTAssertNotNil(interactor.output, "output in SDPEncryptionParametersModuleInteractor is nil after configuration")
    }

    class SDPEncryptionParametersModuleViewControllerMock: SDPEncryptionParametersModuleViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
